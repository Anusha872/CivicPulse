import os
import re
import google.generativeai as genai
from typing import List, Dict, Any
from database import SessionLocal, Complaint, LostItem, FoundItem

# System Prompt
SYSTEM_PROMPT = """
You are the CivicPulse Assistant, a warm, polite, and helpful "front desk assistant" for CivicPulse.

YOUR PURPOSE:
1. Assist community members in reporting civic complaints (e.g., potholes, broken streetlights).
2. Help users report or search for lost & found items.
3. Provide guidance on government paperwork.
4. Answer FAQs about how CivicPulse works.

CONVERSATIONAL BEHAVIOR:
- Sound like a friendly front-desk assistant.
- Ask natural follow-up questions to gather details (what happened, where, when).
- For complaints or lost items: Gather necessary details step-by-step. Once you have enough details (description, category, location, date), YOU MUST call the appropriate function (log_complaint, log_lost_item, log_found_item) to save it. 
- After logging, confirm the ID to the user: "I've logged your report. Your ID is [ID]. An admin will review it shortly."

LOST & FOUND MATCHING RULE:
- If a user is reporting a LOST item or looking for a lost item, use the `search_found_items` function to see if anyone has found something similar.
- CRITICAL: If potential matches exist, DO NOT immediately reveal full details or images. Instead, ask the user a verifying question first (e.g., "What name is on the item?" or "Any specific identifying marks?").
- Only after they answer with a plausible detail, tell them about the match and instruct them to visit the admin/claim page to finalize pickup. You CANNOT finalize a claim.

CRITICAL SECURITY BOUNDARIES:
1. NEVER VERIFY DOCUMENTS yourself. Human admins do this.
2. NEVER APPROVE OR REJECT CLAIMS. Only admins can change status.
3. NO PASSWORDS OR SENSITIVE CREDENTIALS.
4. REDIRECT FULL ID NUMBERS: If a user pastes full sensitive document/ID numbers (e.g. 123-456-789), DO NOT log it. Stop and redirect them to the secure upload form.

HONESTY:
If you genuinely don't know the answer or can't help, say so honestly rather than guessing, and offer to connect the user to an admin.
"""

# Define Python Functions for Gemini to call (Tools)

def log_complaint(description: str, category: str, location: str, date: str) -> str:
    """Logs a civic complaint to the database."""
    db = SessionLocal()
    try:
        new_complaint = Complaint(description=description, category=category, location=location, date=date)
        db.add(new_complaint)
        db.commit()
        db.refresh(new_complaint)
        return f"SUCCESS: Complaint logged with ID {new_complaint.id}."
    finally:
        db.close()

def log_lost_item(description: str, category: str, location: str, date: str) -> str:
    """Logs a lost item report to the database."""
    db = SessionLocal()
    try:
        new_item = LostItem(description=description, category=category, location=location, date=date)
        db.add(new_item)
        db.commit()
        db.refresh(new_item)
        return f"SUCCESS: Lost item logged with ID {new_item.id}."
    finally:
        db.close()

def log_found_item(description: str, category: str, location: str, date: str) -> str:
    """Logs a found item report to the database."""
    db = SessionLocal()
    try:
        new_item = FoundItem(description=description, category=category, location=location, date=date)
        db.add(new_item)
        db.commit()
        db.refresh(new_item)
        return f"SUCCESS: Found item logged with ID {new_item.id}."
    finally:
        db.close()

def search_found_items(category: str, location_hint: str) -> str:
    """Searches the database for found items that might match a user's lost item."""
    db = SessionLocal()
    try:
        # Simple search for matching category and location substring
        results = db.query(FoundItem).filter(
            FoundItem.category.ilike(f"%{category}%"),
            FoundItem.location.ilike(f"%{location_hint}%")
        ).all()
        
        if not results:
            return "No matching found items currently in the database."
        
        matches = []
        for r in results:
            matches.append(f"Found Item ID {r.id}: Category: {r.category}, Found at: {r.location}, Date: {r.date}, Description (DO NOT REVEAL FULLY TO USER YET): {r.description}")
        return "Found potential matches:\n" + "\n".join(matches)
    finally:
        db.close()

# The Tools list
TOOLS = [log_complaint, log_lost_item, log_found_item, search_found_items]

def get_gemini_response(user_msg: str, history: List[Dict[str, Any]]) -> str:
    """
    Main function to get a response from Gemini.
    Includes handling of function calls.
    """
    genai.configure(api_key=os.getenv("GEMINI_API_KEY"))
    
    # Try the models in order
    model_name = "gemini-2.5-flash" # Use an updated model that supports robust tool calling
    try:
        model = genai.GenerativeModel(model_name=model_name, system_instruction=SYSTEM_PROMPT, tools=TOOLS)
    except Exception:
        # Fallback to older flash if 2.5 is unavailable in this SDK
        model = genai.GenerativeModel(model_name="gemini-2.0-flash", system_instruction=SYSTEM_PROMPT, tools=TOOLS)

    # Convert history format for Gemini SDK (we need to preserve function call history if applicable, 
    # but for simplicity we'll just pass text history, as the SDK handles single-turn function calling well
    # or multi-turn if we use start_chat)
    
    formatted_history = []
    for msg in history:
        role = "model" if msg["role"].lower() in ["model", "assistant", "bot"] else "user"
        formatted_history.append({"role": role, "parts": [msg["content"]]})
        
    try:
        chat_session = model.start_chat(history=formatted_history)
        response = chat_session.send_message(user_msg)
        
        # If the model decided to call a function
        while response.function_call:
            fc = response.function_call
            func_name = fc.name
            args = {k: v for k, v in fc.args.items()}
            
            # Dispatch to our python functions
            func_result = ""
            if func_name == "log_complaint":
                func_result = log_complaint(**args)
            elif func_name == "log_lost_item":
                func_result = log_lost_item(**args)
            elif func_name == "log_found_item":
                func_result = log_found_item(**args)
            elif func_name == "search_found_items":
                func_result = search_found_items(**args)
            else:
                func_result = "Error: Unknown function."
                
            # Send the result back to the model so it can formulate a final answer
            response = chat_session.send_message(
                genai.protos.Part(
                    function_response=genai.protos.FunctionResponse(
                        name=func_name,
                        response={"result": func_result}
                    )
                )
            )
            
        return response.text

    except Exception as e:
        print(f"Gemini API Error: {e}")
        return smart_assistant_fallback(user_msg)


def smart_assistant_fallback(user_msg: str) -> str:
    """
    Intelligent conversational fallback engine that adheres strictly to CivicPulse
    persona, rules, follow-ups, and safety boundaries if Gemini API fails or hits quota.
    """
    msg_lower = user_msg.lower().strip()

    # Rule 1: Redirect sensitive document/ID numbers or password requests
    if re.search(r'\b\d{6,15}\b', msg_lower) or any(k in msg_lower for k in ["passport no", "citizenship no", "license no", "password", "pin"]):
        return (
            "🛡️ **Security Notice**: For your privacy and protection, please **do not share full document ID numbers or sensitive credentials** in public chat.\n\n"
            "Please use the secure document upload form on our portal to submit sensitive files for review!"
        )

    # Rule 2: Verification / Claim Approval Queries
    if any(k in msg_lower for k in ["verify", "verification", "approve", "approval", "reject", "authorize"]):
        return (
            "As the CivicPulse Assistant, I can guide you through preparing your information, but **I cannot verify documents or approve claims myself**.\n\n"
            "All identity documents and claims are reviewed strictly by **human administrators**."
        )

    # Rule 3: Lost & Found Items
    if any(k in msg_lower for k in ["lost", "found", "passport", "license", "wallet", "bag"]):
        return (
            "⚠️ **I'm experiencing high traffic right now, so I'm using backup assistance.**\n\n"
            "I'm sorry to hear about your lost/found item! To officially log this, please visit the **Lost & Found Form** on the CivicPulse website so our admins can review it."
        )

    # Rule 4: Civic Complaints
    if any(k in msg_lower for k in ["complaint", "pothole", "streetlight", "garbage", "water", "road"]):
        return (
            "⚠️ **I'm experiencing high traffic right now, so I'm using backup assistance.**\n\n"
            "To make sure city officials resolve this quickly, please click the **Report Issue** button on the website dashboard to submit a formal complaint."
        )

    # Default
    return (
        "⚠️ **I'm experiencing high traffic right now, so I'm using backup assistance.**\n\n"
        "Thank you for contacting CivicPulse! 👋 I can help you with:\n"
        "1. **Filing a Civic Complaint**\n"
        "2. **Reporting Lost/Found Documents**\n"
        "3. **Locating Government Offices**\n\n"
        "Could you tell me a bit more about what you need assistance with today?"
    )

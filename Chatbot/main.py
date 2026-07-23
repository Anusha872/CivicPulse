import os
import warnings
from typing import List, Optional
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
from pydantic import BaseModel, Field
from dotenv import load_dotenv

# Import the refactored logic
from chatbot_logic import get_gemini_response
from admin_routes import router as admin_router
from database import Base, engine

warnings.filterwarnings("ignore", category=FutureWarning)
load_dotenv()

GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
if not GEMINI_API_KEY or GEMINI_API_KEY == "your_gemini_api_key_here":
    print("⚠️ WARNING: GEMINI_API_KEY is missing or unconfigured in .env file!")

# Create DB tables
Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="CivicPulse Chatbot & Admin API",
    description="Backend service providing AI assistant responses and database operations for CivicPulse",
    version="2.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include Admin Router
app.include_router(admin_router)

class MessageItem(BaseModel):
    role: str = Field(..., description="Role of the sender: 'user' or 'model'")
    content: str = Field(..., description="Text content of the message")

class ChatRequest(BaseModel):
    message: str = Field(..., description="The user's current message")
    conversation_history: Optional[List[MessageItem]] = Field(
        default=[],
        description="List of prior messages for maintaining multi-turn context"
    )

class ChatResponse(BaseModel):
    reply: str = Field(..., description="The AI assistant's generated response")


# ==================== API ENDPOINTS ==================== #

@app.post("/chat", response_model=ChatResponse)
async def chat_endpoint(request: ChatRequest):
    if not request.message or not request.message.strip():
        raise HTTPException(status_code=400, detail="Message cannot be empty.")

    # Call the encapsulated Gemini logic
    # Convert Pydantic objects to dicts for the logic handler
    history_dicts = [{"role": msg.role, "content": msg.content} for msg in request.conversation_history]
    
    reply_text = get_gemini_response(request.message, history_dicts)
    return ChatResponse(reply=reply_text)


# ==================== STATIC FILE ROUTES ==================== #

static_dir = os.path.join(os.path.dirname(__file__), "static")
if os.path.exists(static_dir):
    app.mount("/static", StaticFiles(directory=static_dir), name="static")

@app.get("/style.css")
def get_css():
    return FileResponse(os.path.join(static_dir, "style.css"), media_type="text/css")

@app.get("/script.js")
def get_js():
    return FileResponse(os.path.join(static_dir, "script.js"), media_type="application/javascript")

@app.get("/")
def read_root():
    index_file = os.path.join(static_dir, "index.html")
    if os.path.exists(index_file):
        return FileResponse(index_file)
    return {
        "status": "CivicPulse Chatbot API is running",
        "chat_endpoint": "/chat",
        "documentation": "/docs"
    }

@app.get("/api/status")
def api_status():
    return {"status": "ok", "message": "CivicPulse Chatbot backend active (v2.0)"}
import sys
from chatbot_logic import get_gemini_response
history = [{"role": "user", "content": "I want to file a complaint about a broken streetlight on Ring Road. It's been broken for 3 days."}]
try:
    print(get_gemini_response("Please log this.", history))
except Exception as e:
    print("FATAL ERROR:", e)

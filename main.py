from fastapi import FastAPI
from pydantic import BaseModel
import anthropic

app = FastAPI()
client = anthropic.Anthropic(api_key="YOUR_API_KEY_HERE")

class ChatRequest(BaseModel):
    message: str

@app.post("/chat")
def chat(req: ChatRequest):
    response = client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=500,
        messages=[{"role": "user", "content": req.message}]
    )
    reply = response.content[0].text
    return {"reply": reply}

/**
 * CivicPulse AI Front Desk Assistant
 * -----------------------------------
 * JavaScript logic connecting the UI interface to the FastAPI backend at /chat.
 */

const CHAT_API_URL = "/chat"; // Relative path so it works seamlessly on http://localhost:8000/chat

let conversationHistory = [];

// DOM References
const chatMessagesViewport = document.getElementById("main-chat-messages");
const chatForm = document.getElementById("main-chat-form");
const userInputField = document.getElementById("main-user-input");
const sendButton = document.getElementById("main-send-btn");
const resetChatBtn = document.getElementById("reset-main-chat");
const suggestionChips = document.querySelectorAll(".chip");

// Initialize listeners on load
document.addEventListener("DOMContentLoaded", () => {
    userInputField.focus();

    // 1. Form Submit
    chatForm.addEventListener("submit", (e) => {
        e.preventDefault();
        const text = userInputField.value.trim();
        if (text) {
            sendMessage(text);
            userInputField.value = "";
        }
    });

    // 2. Reset Chat Button
    resetChatBtn.addEventListener("click", () => {
        if (confirm("Start a new conversation?")) {
            conversationHistory = [];
            chatMessagesViewport.innerHTML = `
                <div class="msg-row model">
                    <div class="avatar"><i class="fa-solid fa-robot"></i></div>
                    <div class="bubble">
                        <p class="greeting-heading">Hi! 👋 How can I help you today?</p>
                        <p>Conversation reset! I am ready to help you with civic complaints, lost documents, or government paperwork.</p>
                    </div>
                </div>
            `;
            userInputField.focus();
        }
    });

    // 3. Quick Chips Click
    suggestionChips.forEach(chip => {
        chip.addEventListener("click", () => {
            const query = chip.getAttribute("data-query");
            if (query) {
                sendMessage(query);
            }
        });
    });
});

/**
 * Sends user text to the FastAPI backend POST /chat endpoint
 * @param {string} text 
 */
async function sendMessage(text) {
    // Append User Message to UI
    appendBubble("user", text);

    // Show Typing Indicator
    const typingIndicator = appendTypingIndicator();

    // Lock Input during request
    userInputField.disabled = true;
    sendButton.disabled = true;

    try {
        const response = await fetch(CHAT_API_URL, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                message: text,
                conversation_history: conversationHistory
            })
        });

        removeTypingIndicator(typingIndicator);

        if (!response.ok) {
            const errJson = await response.json().catch(() => ({}));
            throw new Error(errJson.detail || `Server error (${response.status})`);
        }

        const data = await response.json();
        const replyText = data.reply;

        // Update multi-turn history
        conversationHistory.push({ role: "user", content: text });
        conversationHistory.push({ role: "model", content: replyText });

        // Append Assistant Response to UI
        appendBubble("model", replyText);

    } catch (error) {
        console.error("Chat API error:", error);
        removeTypingIndicator(typingIndicator);
        appendBubble(
            "model",
            "⚠️ **Connection Issue**: Unable to connect to the backend server. Please ensure your Python FastAPI backend is running on `http://localhost:8000`."
        );
    } finally {
        userInputField.disabled = false;
        sendButton.disabled = false;
        userInputField.focus();
    }
}

/**
 * Appends a message bubble to the viewport
 */
function appendBubble(role, text) {
    const row = document.createElement("div");
    row.classList.add("msg-row", role);

    const avatar = document.createElement("div");
    avatar.classList.add("avatar");
    avatar.innerHTML = role === "user" ? '<i class="fa-solid fa-user"></i>' : '<i class="fa-solid fa-robot"></i>';

    const bubble = document.createElement("div");
    bubble.classList.add("bubble");
    bubble.innerHTML = formatMarkdown(text);

    row.appendChild(avatar);
    row.appendChild(bubble);
    chatMessagesViewport.appendChild(row);

    // Scroll to bottom smoothly
    chatMessagesViewport.scrollTop = chatMessagesViewport.scrollHeight;
}

/**
 * Appends 3-dot typing indicator
 */
function appendTypingIndicator() {
    const row = document.createElement("div");
    row.classList.add("msg-row", "model", "typing-row");

    const avatar = document.createElement("div");
    avatar.classList.add("avatar");
    avatar.innerHTML = '<i class="fa-solid fa-robot"></i>';

    const bubble = document.createElement("div");
    bubble.classList.add("bubble", "typing-dots");
    bubble.innerHTML = `
        <span></span>
        <span></span>
        <span></span>
    `;

    row.appendChild(avatar);
    row.appendChild(bubble);
    chatMessagesViewport.appendChild(row);
    chatMessagesViewport.scrollTop = chatMessagesViewport.scrollHeight;

    return row;
}

function removeTypingIndicator(el) {
    if (el && el.parentNode) {
        el.parentNode.removeChild(el);
    }
}

/**
 * Formats basic markdown bold, lists, and newlines
 */
function formatMarkdown(text) {
    if (!text) return "";
    let formatted = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
    formatted = formatted.replace(/^\* (.*$)/gim, '<li>$1</li>');
    formatted = formatted.replace(/^- (.*$)/gim, '<li>$1</li>');
    if (formatted.includes('<li>')) {
        formatted = formatted.replace(/(<li>.*<\/li>)/gs, '<ul>$1</ul>');
    }
    const paragraphs = formatted.split(/\n\n+/);
    return paragraphs.map(p => {
        if (p.trim().startsWith('<ul>') || p.trim().startsWith('<li>')) return p;
        return `<p>${p.replace(/\n/g, '<br>')}</p>`;
    }).join('');
}

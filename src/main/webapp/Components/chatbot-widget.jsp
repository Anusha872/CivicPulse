<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<!-- FontAwesome Icons for Chatbot Widget -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- ==================== CIVICPULSE REAL-TIME AI CHATBOT WIDGET ==================== -->

<!-- Floating Chat Trigger Button (Bottom-Right Corner) -->
<button id="cp-chat-trigger" class="cp-chat-trigger" aria-label="Open AI Assistant" title="CivicPulse AI Assistant">
    <i class="fa-solid fa-robot icon-bot"></i>
    <i class="fa-solid fa-xmark icon-close"></i>
    <span id="cp-chat-badge" class="cp-chat-badge">1</span>
</button>

<!-- Floating Chat Window Container -->
<div id="cp-chat-window" class="cp-chat-window cp-hidden">
    <!-- Header -->
    <div class="cp-chat-header">
        <div class="cp-assistant-brand">
            <div class="cp-avatar-box">
                <i class="fa-solid fa-robot"></i>
                <span class="cp-status-dot"></span>
            </div>
            <div class="cp-assistant-text">
                <h4>CivicPulse AI Assistant</h4>
                <span class="cp-subtext"><i class="fa-solid fa-circle text-online"></i> Online &amp; Ready</span>
            </div>
        </div>
        <div class="cp-header-actions">
            <button id="cp-clear-btn" class="cp-icon-btn" title="Reset Conversation"><i class="fa-solid fa-rotate-right"></i></button>
            <button id="cp-close-btn" class="cp-icon-btn" title="Minimize Chat"><i class="fa-solid fa-minus"></i></button>
        </div>
    </div>

    <!-- Security & Verification Disclaimer -->
    <div class="cp-security-banner">
        <i class="fa-solid fa-shield-halved"></i>
        <span>Official verification &amp; claim approvals are conducted by human admins.</span>
    </div>

    <!-- Messages Container -->
    <div id="cp-chat-messages" class="cp-chat-messages">
        <div class="cp-msg-row model">
            <div class="cp-msg-avatar"><i class="fa-solid fa-robot"></i></div>
            <div class="cp-msg-bubble">
                <p>Hello! 👋 I'm your <strong>CivicPulse Assistant</strong>.</p>
                <p>How can I help you today? Ask me about:</p>
                <ul>
                    <li>Filing a civic complaint (potholes, streetlights, sanitation)</li>
                    <li>Reporting lost identity documents (passport, license, citizenship)</li>
                    <li>Finding government office paperwork guidance</li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Quick Suggestion Action Chips -->
    <div class="cp-suggestion-chips">
        <button class="cp-chip" data-query="How do I file a complaint about broken streetlights?">🚨 File Complaint</button>
        <button class="cp-chip" data-query="I lost my driving license. How can I report it?">🔍 Lost Document</button>
        <button class="cp-chip" data-query="Which government office handles citizenship certificates?">🏛️ Govt Office</button>
        <button class="cp-chip" data-query="How does document verification work on CivicPulse?">🛡️ Verification FAQ</button>
    </div>

    <!-- Input Composer -->
    <form id="cp-chat-form" class="cp-chat-input-area">
        <input 
            type="text" 
            id="cp-user-input" 
            placeholder="Ask about complaints, lost documents, or govt offices..." 
            autocomplete="off" 
            required 
        />
        <button type="submit" id="cp-send-btn" title="Send Message">
            <i class="fa-solid fa-paper-plane"></i>
        </button>
    </form>
</div>

<!-- ==================== WIDGET STYLES ==================== -->
<style>
/* Trigger Floating Button */
.cp-chat-trigger {
    position: fixed;
    bottom: 24px;
    right: 24px;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background: linear-gradient(135deg, #0d9488 0%, #0284c7 100%);
    color: #ffffff;
    border: none;
    cursor: pointer;
    box-shadow: 0 10px 25px rgba(13, 148, 136, 0.4);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    z-index: 999999;
    transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.cp-chat-trigger:hover {
    transform: scale(1.08);
}

.cp-chat-trigger .icon-close { display: none; }
.cp-chat-trigger.active .icon-bot { display: none; }
.cp-chat-trigger.active .icon-close { display: block; }

.cp-chat-badge {
    position: absolute;
    top: -2px;
    right: -2px;
    background: #ef4444;
    color: #ffffff;
    font-size: 0.72rem;
    font-weight: 700;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 2px solid #ffffff;
}

/* Chat Window Container */
.cp-chat-window {
    position: fixed;
    bottom: 96px;
    right: 24px;
    width: 380px;
    max-width: calc(100vw - 32px);
    height: 560px;
    max-height: calc(100vh - 120px);
    background: #ffffff;
    border-radius: 20px;
    box-shadow: 0 20px 40px rgba(15, 23, 42, 0.22);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    z-index: 999998;
    border: 1px solid #e2e8f0;
    transition: opacity 0.25s ease, transform 0.25s ease, visibility 0.25s ease;
    transform: translateY(0);
    opacity: 1;
    visibility: visible;
    font-family: 'Inter', system-ui, -apple-system, sans-serif;
}

.cp-chat-window.cp-hidden {
    opacity: 0;
    visibility: hidden;
    transform: translateY(20px);
    pointer-events: none;
}

/* Header */
.cp-chat-header {
    background: linear-gradient(135deg, #0f766e 0%, #0369a1 100%);
    color: #ffffff;
    padding: 14px 18px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.cp-assistant-brand {
    display: flex;
    align-items: center;
    gap: 12px;
}

.cp-avatar-box {
    position: relative;
    width: 38px;
    height: 38px;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    color: #ffffff;
}

.cp-status-dot {
    position: absolute;
    bottom: 2px;
    right: 2px;
    width: 8px;
    height: 8px;
    background: #22c55e;
    border: 2px solid #0f766e;
    border-radius: 50%;
}

.cp-assistant-text h4 {
    font-size: 0.95rem;
    font-weight: 600;
    margin: 0;
    line-height: 1.2;
    color: #ffffff;
}

.cp-subtext {
    font-size: 0.72rem;
    opacity: 0.9;
    color: #e0f2fe;
}

.text-online {
    color: #4ade80;
    font-size: 0.5rem;
    vertical-align: middle;
}

.cp-header-actions {
    display: flex;
    gap: 4px;
}

.cp-icon-btn {
    background: transparent;
    border: none;
    color: rgba(255, 255, 255, 0.85);
    width: 28px;
    height: 28px;
    border-radius: 50%;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.2s ease;
}

.cp-icon-btn:hover {
    background: rgba(255, 255, 255, 0.2);
    color: #ffffff;
}

/* Security Disclaimer Banner */
.cp-security-banner {
    background: #fffbebf5;
    border-bottom: 1px solid #fef3c7;
    color: #92400e;
    font-size: 0.73rem;
    padding: 6px 14px;
    display: flex;
    align-items: center;
    gap: 8px;
    font-weight: 500;
}

.cp-security-banner i {
    color: #d97706;
}

/* Chat Messages Box */
.cp-chat-messages {
    flex: 1;
    padding: 16px;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
    gap: 14px;
    background: #f8fafc;
}

.cp-msg-row {
    display: flex;
    gap: 10px;
    max-width: 85%;
}

.cp-msg-row.user {
    align-self: flex-end;
    flex-direction: row-reverse;
}

.cp-msg-row.model {
    align-self: flex-start;
}

.cp-msg-avatar {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    background: #e2e8f0;
    color: #0f766e;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.85rem;
    flex-shrink: 0;
}

.cp-msg-row.user .cp-msg-avatar {
    background: #0284c7;
    color: #ffffff;
}

.cp-msg-bubble {
    padding: 12px 14px;
    border-radius: 14px;
    font-size: 0.88rem;
    line-height: 1.45;
    word-break: break-word;
}

.cp-msg-row.model .cp-msg-bubble {
    background: #ffffff;
    color: #0f172a;
    border: 1px solid #e2e8f0;
    border-top-left-radius: 4px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.03);
}

.cp-msg-row.user .cp-msg-bubble {
    background: linear-gradient(135deg, #0d9488 0%, #0284c7 100%);
    color: #ffffff;
    border-top-right-radius: 4px;
}

.cp-msg-bubble p { margin-bottom: 6px; }
.cp-msg-bubble p:last-child { margin-bottom: 0; }
.cp-msg-bubble ul { padding-left: 18px; margin: 4px 0; }
.cp-msg-bubble li { margin-bottom: 2px; }

/* Typing Dots Animation */
.cp-typing-indicator {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    padding: 8px 12px;
}

.cp-typing-dot {
    width: 6px;
    height: 6px;
    background: #64748b;
    border-radius: 50%;
    animation: cpPulse 1.4s infinite ease-in-out both;
}

.cp-typing-dot:nth-child(1) { animation-delay: 0s; }
.cp-typing-dot:nth-child(2) { animation-delay: 0.2s; }
.cp-typing-dot:nth-child(3) { animation-delay: 0.4s; }

@keyframes cpPulse {
    0%, 80%, 100% { transform: scale(0.6); opacity: 0.4; }
    40% { transform: scale(1.1); opacity: 1; }
}

/* Suggestion Action Chips */
.cp-suggestion-chips {
    padding: 8px 12px;
    display: flex;
    gap: 6px;
    overflow-x: auto;
    background: #ffffff;
    border-top: 1px solid #f1f5f9;
}

.cp-chip {
    white-space: nowrap;
    background: #f1f5f9;
    color: #334155;
    font-size: 0.75rem;
    font-weight: 500;
    padding: 6px 12px;
    border-radius: 16px;
    cursor: pointer;
    border: 1px solid #e2e8f0;
    transition: all 0.2s ease;
}

.cp-chip:hover {
    background: #e0f2fe;
    color: #0284c7;
    border-color: #bae6fd;
}

/* Input Area */
.cp-chat-input-area {
    padding: 12px 14px;
    background: #ffffff;
    border-top: 1px solid #e2e8f0;
    display: flex;
    align-items: center;
    gap: 8px;
}

.cp-chat-input-area input {
    flex: 1;
    border: 1px solid #cbd5e1;
    border-radius: 20px;
    padding: 10px 16px;
    font-size: 0.88rem;
    outline: none;
    transition: all 0.2s ease;
}

.cp-chat-input-area input:focus {
    border-color: #0d9488;
    box-shadow: 0 0 0 3px rgba(13, 148, 136, 0.15);
}

.cp-chat-input-area button {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    background: #0d9488;
    color: #ffffff;
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.9rem;
    transition: all 0.2s ease;
}

.cp-chat-input-area button:hover {
    background: #0f766e;
    transform: scale(1.05);
}

.cp-chat-input-area button:disabled {
    background: #cbd5e1;
    cursor: not-allowed;
    transform: none;
}
</style>

<!-- ==================== WIDGET JAVASCRIPT ==================== -->
<script>
(function() {
    const CHAT_BACKEND_URL = "http://localhost:8000/chat";
    
    // Load session history if present
    let history = [];
    try {
        const saved = sessionStorage.getItem("cp_chat_history");
        if (saved) history = JSON.parse(saved);
    } catch(e) {}

    document.addEventListener("DOMContentLoaded", function() {
        const triggerBtn = document.getElementById("cp-chat-trigger");
        const chatWin = document.getElementById("cp-chat-window");
        const closeBtn = document.getElementById("cp-close-btn");
        const clearBtn = document.getElementById("cp-clear-btn");
        const messagesBox = document.getElementById("cp-chat-messages");
        const chatForm = document.getElementById("cp-chat-form");
        const userInput = document.getElementById("cp-user-input");
        const sendBtn = document.getElementById("cp-send-btn");
        const badge = document.getElementById("cp-chat-badge");
        const chips = document.querySelectorAll(".cp-chip");

        // Helper to toggle window open/close
        window.toggleCivicChatbot = function(openState) {
            if (openState === true) {
                chatWin.classList.remove("cp-hidden");
                triggerBtn.classList.add("active");
                userInput.focus();
                if (badge) badge.style.display = "none";
            } else if (openState === false) {
                chatWin.classList.add("cp-hidden");
                triggerBtn.classList.remove("active");
            } else {
                chatWin.classList.toggle("cp-hidden");
                triggerBtn.classList.toggle("active");
                if (!chatWin.classList.contains("cp-hidden")) {
                    userInput.focus();
                    if (badge) badge.style.display = "none";
                }
            }
        };

        if (triggerBtn) triggerBtn.addEventListener("click", function() { toggleCivicChatbot(); });
        if (closeBtn) closeBtn.addEventListener("click", function() { toggleCivicChatbot(false); });

        // Restore prior rendered history if present
        if (history && history.length > 0) {
            history.forEach(function(item) {
                appendBubble(item.role, item.content, false);
            });
        }

        // Reset Conversation
        if (clearBtn) {
            clearBtn.addEventListener("click", function() {
                if (confirm("Reset chat conversation?")) {
                    history = [];
                    sessionStorage.removeItem("cp_chat_history");
                    messagesBox.innerHTML = `
                        <div class="cp-msg-row model">
                            <div class="cp-msg-avatar"><i class="fa-solid fa-robot"></i></div>
                            <div class="cp-msg-bubble">
                                <p>Conversation reset! 👋 How can I help you today with CivicPulse?</p>
                            </div>
                        </div>
                    `;
                }
            });
        }

        // Form Submit
        if (chatForm) {
            chatForm.addEventListener("submit", function(e) {
                e.preventDefault();
                const text = userInput.value.trim();
                if (text) {
                    sendChatMessage(text);
                    userInput.value = "";
                }
            });
        }

        // Suggestion Chips
        chips.forEach(function(chip) {
            chip.addEventListener("click", function() {
                const query = chip.getAttribute("data-query");
                if (query) {
                    toggleCivicChatbot(true);
                    sendChatMessage(query);
                }
            });
        });

        // Main Send Function
        async function sendChatMessage(text) {
            appendBubble("user", text, true);
            const typingEl = appendTyping();

            userInput.disabled = true;
            sendBtn.disabled = true;

            try {
                const res = await fetch(CHAT_BACKEND_URL, {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({
                        message: text,
                        conversation_history: history
                    })
                });

                removeTyping(typingEl);

                if (!res.ok) {
                    const errData = await res.json().catch(() => ({}));
                    throw new Error(errData.detail || `Server error (\${res.status})`);
                }

                const data = await res.json();
                const replyText = data.reply;

                // Update state & sessionStorage
                history.push({ role: "user", content: text });
                history.push({ role: "model", content: replyText });
                sessionStorage.setItem("cp_chat_history", JSON.stringify(history));

                appendBubble("model", replyText, true);

            } catch (err) {
                console.error("CivicPulse Chatbot Error:", err);
                removeTyping(typingEl);
                appendBubble("model", "⚠️ Unable to connect to CivicPulse AI server. Please ensure FastAPI backend is running on http://localhost:8000.", true);
            } finally {
                userInput.disabled = false;
                sendBtn.disabled = false;
                userInput.focus();
            }
        }

        function appendBubble(role, text, shouldScroll) {
            const row = document.createElement("div");
            row.classList.add("cp-msg-row", role);

            const avatar = document.createElement("div");
            avatar.classList.add("cp-msg-avatar");
            avatar.innerHTML = role === "user" ? '<i class="fa-solid fa-user"></i>' : '<i class="fa-solid fa-robot"></i>';

            const bubble = document.createElement("div");
            bubble.classList.add("cp-msg-bubble");
            bubble.innerHTML = formatMarkdown(text);

            row.appendChild(avatar);
            row.appendChild(bubble);
            messagesBox.appendChild(row);

            if (shouldScroll) {
                messagesBox.scrollTop = messagesBox.scrollHeight;
            }
        }

        function appendTyping() {
            const row = document.createElement("div");
            row.classList.add("cp-msg-row", "model");

            const avatar = document.createElement("div");
            avatar.classList.add("cp-msg-avatar");
            avatar.innerHTML = '<i class="fa-solid fa-robot"></i>';

            const bubble = document.createElement("div");
            bubble.classList.add("cp-msg-bubble", "cp-typing-indicator");
            bubble.innerHTML = '<span class="cp-typing-dot"></span><span class="cp-typing-dot"></span><span class="cp-typing-dot"></span>';

            row.appendChild(avatar);
            row.appendChild(bubble);
            messagesBox.appendChild(row);
            messagesBox.scrollTop = messagesBox.scrollHeight;
            return row;
        }

        function removeTyping(el) {
            if (el && el.parentNode) el.parentNode.removeChild(el);
        }

        function formatMarkdown(text) {
            if (!text) return "";
            let fmt = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
            fmt = fmt.replace(/^\* (.*$)/gim, '<li>$1</li>');
            fmt = fmt.replace(/^- (.*$)/gim, '<li>$1</li>');
            if (fmt.includes('<li>')) {
                fmt = fmt.replace(/(<li>.*<\/li>)/gs, '<ul>$1</ul>');
            }
            const pars = fmt.split(/\n\n+/);
            return pars.map(p => {
                if (p.trim().startsWith('<ul>') || p.trim().startsWith('<li>')) return p;
                return `<p>\${p.replace(/\\n/g, '<br>')}</p>`;
            }).join('');
        }
    });
})();
</script>

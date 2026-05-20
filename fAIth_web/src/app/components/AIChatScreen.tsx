import { useState } from "react";
import { Send, Sparkles, BookOpen } from "lucide-react";

export default function AIChatScreen() {
  const [message, setMessage] = useState("");

  const [messages, setMessages] = useState([
    {
      role: "assistant",
      content:
        "Hello! I'm here to help guide you on your spiritual journey. How can I assist you today?",
    },
  ]);

  const suggestedPrompts = [
    "Explain this Bible verse",
    "Prayer for guidance",
    "Encouraging scripture",
    "Biblical wisdom",
    "Help me understand forgiveness",
    "Verses about anxiety",
  ];

  const handleSend = (customMessage?: string) => {
    const finalMessage = customMessage || message;

    if (!finalMessage.trim()) return;

    setMessages((prev) => [
      ...prev,
      {
        role: "user",
        content: finalMessage,
      },
    ]);

    setMessage("");

    setTimeout(() => {
      setMessages((prev) => [
        ...prev,
        {
          role: "assistant",
          content:
            "I'd be happy to help you explore that. Let me share some relevant scripture and wisdom...",
        },
      ]);
    }, 1000);
  };

  return (
    <div className="h-screen w-full bg-[#F8F6F2] flex flex-col overflow-hidden">
      {/* Header */}
      <div className="bg-gradient-to-br from-[#111827] to-[#0f1419] text-white p-6 shadow-lg">
        <div className="flex items-center gap-3">
          <div className="bg-gradient-to-br from-[#D4A574] to-[#C97B63] p-3 rounded-2xl">
            <Sparkles className="w-6 h-6 text-white" />
          </div>

          <div>
            <h1 className="text-xl font-semibold">Ask fAIth</h1>
            <p className="text-[#E5D3B3]/70 text-sm">
              Your AI Spiritual Guide
            </p>
          </div>
        </div>
      </div>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto p-6 space-y-4">
        {messages.map((msg, idx) => (
          <div
            key={idx}
            className={`flex gap-3 ${
              msg.role === "user" ? "flex-row-reverse" : ""
            }`}
          >
            {/* Avatar */}
            <div
              className={`w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0 ${
                msg.role === "assistant"
                  ? "bg-gradient-to-br from-[#D4A574] to-[#C97B63]"
                  : "bg-[#111827]"
              }`}
            >
              {msg.role === "assistant" ? (
                <Sparkles className="w-5 h-5 text-white" />
              ) : (
                <span className="text-white text-sm">S</span>
              )}
            </div>

            {/* Bubble */}
            <div
              className={`max-w-[75%] rounded-2xl p-4 ${
                msg.role === "assistant"
                  ? "bg-white border border-gray-200 shadow-sm text-[#111827]"
                  : "bg-gradient-to-br from-[#111827] to-[#0f1419] text-white"
              }`}
            >
              <p className="text-sm leading-relaxed">
                {msg.content}
              </p>
            </div>
          </div>
        ))}

        {/* Recommended verse */}
        {messages.length === 1 && (
          <div className="bg-gradient-to-br from-[#D4A574]/10 to-[#C97B63]/10 rounded-2xl p-4 border border-[#D4A574]/20">
            <div className="flex items-start gap-3">
              <BookOpen className="w-5 h-5 text-[#D4A574] flex-shrink-0 mt-0.5" />

              <div>
                <p className="text-xs text-[#D4A574] mb-2">
                  Recommended Verse
                </p>

                <p className="text-sm text-[#111827] leading-relaxed">
                  "Trust in the Lord with all your heart and
                  lean not on your own understanding."
                </p>

                <p className="text-xs text-gray-500 mt-2">
                  Proverbs 3:5
                </p>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Bottom Section */}
      <div className="border-t border-gray-200 bg-white p-4 space-y-3">
        {/* Suggested prompts */}
        <div
          className="flex gap-2 overflow-x-auto pb-1"
          style={{
            scrollbarWidth: "none",
            msOverflowStyle: "none",
          }}
        >
          {suggestedPrompts.map((prompt, idx) => (
            <button
              key={idx}
              onClick={() => handleSend(prompt)}
              className="
                whitespace-nowrap
                bg-[#F8F6F2]
                border border-gray-200
                rounded-full
                px-4 py-2
                text-sm
                text-[#111827]
                hover:border-[#D4A574]
                hover:bg-[#D4A574]/5
                transition-all
                flex-shrink-0
              "
            >
              {prompt}
            </button>
          ))}
        </div>

        {/* Input */}
        <div className="flex items-center gap-2">
          <div className="flex-1 min-w-0">
            <input
              type="text"
              value={message}
              onChange={(e) => setMessage(e.target.value)}
              onKeyDown={(e) =>
                e.key === "Enter" &&
                message.trim() &&
                handleSend()
              }
              placeholder="Ask me anything about faith..."
              className="
        w-full
        rounded-2xl
        border
        border-gray-200
        bg-white
        px-4
        py-3
        text-sm
        text-black
        placeholder:text-gray-400
        focus:outline-none
        focus:ring-2
        focus:ring-[#D4A574]/20
        focus:border-[#D4A574]
      "
            />
          </div>

          <button
            onClick={() => handleSend()}
            disabled={!message.trim()}
            className={`
      w-12
      h-12
      rounded-2xl
      flex
      items-center
      justify-center
      transition-all
      flex-shrink-0
      ${
        message.trim()
          ? "bg-gradient-to-br from-[#D4A574] to-[#C97B63] text-white hover:shadow-lg active:scale-95"
          : "bg-gray-200 text-gray-400 cursor-not-allowed"
      }
    `}
          >
            <Send className="w-5 h-5" />
          </button>
        </div>
      </div>
    </div>
  );
}
import {
  ChevronLeft,
  Star,
  Globe,
  ChevronRight,
  Moon,
} from "lucide-react";

import { useEffect, useState } from "react";

interface AdditionalSettingsScreenProps {
  onBack: () => void;
  onNavigate?: (screen: string) => void;
}

export default function AdditionalSettingsScreen({
  onBack,
  onNavigate,
}: AdditionalSettingsScreenProps) {
  const [darkMode, setDarkMode] = useState(false);
  const [showLanguageSheet, setShowLanguageSheet] =
    useState(false);
  const [selectedLanguage, setSelectedLanguage] =
    useState("english");

  useEffect(() => {
    if (darkMode) {
      document.documentElement.classList.add("dark");
    } else {
      document.documentElement.classList.remove("dark");
    }
  }, [darkMode]);

  return (
    <div className="h-screen w-full bg-background overflow-y-auto pb-20">
      {/* Header */}
      <div className="bg-gradient-to-br from-navy to-[#0f1419] text-ivory p-6 pb-8 shadow-lg">
        <div className="flex items-center gap-4">
          <button
            onClick={onBack}
            className="p-2 hover:bg-white/10 rounded-xl transition-colors"
          >
            <ChevronLeft className="w-6 h-6" />
          </button>

          <div>
            <h1 className="text-2xl">Spiritual Preferences</h1>

            <p className="text-beige/70 text-sm mt-1">
              Personalize your spiritual experience
            </p>
          </div>
        </div>
      </div>

      <div className="p-6 space-y-6">
        {/* Personalization */}
        <div className="space-y-3">
          <h3 className="text-sm text-muted-foreground px-2">
            Personalization
          </h3>

          <div className="bg-card border border-border rounded-2xl overflow-hidden shadow-sm">
            {/* Favorite Verses */}
            <button
              onClick={() => onNavigate?.("favorite-verses")}
              className="w-full p-4 flex items-center gap-4 hover:bg-muted/30 transition-colors border-b border-border"
            >
              <div className="bg-gold/10 p-2.5 rounded-xl">
                <Star className="w-5 h-5 text-gold" />
              </div>

              <div className="flex-1 text-left">
                <p className="text-navy">Favorite Verses</p>

                <p className="text-xs text-muted-foreground mt-0.5">
                  Manage your daily encouragement verses
                </p>
              </div>

              <ChevronRight className="w-5 h-5 text-muted-foreground" />
            </button>

            {/* Language */}
            <button
              onClick={() => setShowLanguageSheet(true)}
              className="w-full p-4 flex items-center gap-4 hover:bg-muted/30 transition-colors border-b border-border"
            >
              <div className="bg-gold/10 p-2.5 rounded-xl">
                <Globe className="w-5 h-5 text-gold" />
              </div>

              <div className="flex-1 text-left">
                <p className="text-navy">Language</p>

                <p className="text-xs text-muted-foreground mt-0.5">
                  {selectedLanguage === "english"
                    ? "English"
                    : "Bahasa Indonesia"}
                </p>
              </div>

              <ChevronRight className="w-5 h-5 text-muted-foreground" />
            </button>

            {/* Dark Mode */}
            <div className="p-4 flex items-center gap-4">
              <div className="bg-navy/10 p-2.5 rounded-xl">
                <Moon className="w-5 h-5 text-navy" />
              </div>

              <div className="flex-1">
                <p className="text-navy">Dark Mode</p>

                <p className="text-xs text-muted-foreground mt-0.5">
                  Switch between light and dark appearance
                </p>
              </div>

              <label className="relative inline-flex items-center cursor-pointer">
                <input
                  type="checkbox"
                  checked={darkMode}
                  onChange={(e) =>
                    setDarkMode(e.target.checked)
                  }
                  className="sr-only peer"
                />

                <div className="w-11 h-6 bg-muted peer-focus:outline-none peer-focus:ring-2 peer-focus:ring-gold/50 rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-gradient-to-r peer-checked:from-gold peer-checked:to-sunset" />
              </label>
            </div>
          </div>
        </div>

        {/* Preview Card */}
        <div className="bg-gradient-to-br from-gold/5 to-sunset/5 border border-gold/20 rounded-2xl p-5">
          <p className="text-xs text-gold mb-2">
            Personalization Preview
          </p>

          <h3 className="text-navy mb-2">
            Your spiritual experience matters
          </h3>

          <p className="text-sm text-muted-foreground leading-relaxed">
            Customize favorite verses, language preferences, and
            dark mode settings to make fAIth feel more personal
            and meaningful.
          </p>
        </div>
      </div>
      {/* Language Bottom Sheet */}
      {showLanguageSheet && (
        <div className="fixed inset-0 z-50 flex items-end">
          {/* Backdrop */}
          <div
            onClick={() => setShowLanguageSheet(false)}
            className="absolute inset-0 bg-black/40 backdrop-blur-sm"
          />

          {/* Bottom Sheet */}
          <div className="relative w-full bg-card rounded-t-[32px] p-6 shadow-2xl animate-in slide-in-from-bottom duration-300">
            {/* Handle */}
            <div className="w-12 h-1.5 bg-muted rounded-full mx-auto mb-6" />

            <div className="mb-6">
              <h2 className="text-xl text-navy">
                Choose Language
              </h2>

              <p className="text-sm text-muted-foreground mt-1">
                Select your preferred app language
              </p>
            </div>

            <div className="space-y-3">
              {/* English */}
              <button
                onClick={() => {
                  setSelectedLanguage("english");
                  setShowLanguageSheet(false);
                }}
                className={`w-full flex items-center gap-4 rounded-2xl border p-4 transition-all ${
                  selectedLanguage === "english"
                    ? "border-gold bg-gold/5"
                    : "border-border bg-card"
                }`}
              >
                <div className="text-3xl">🇺🇸</div>

                <div className="flex-1 text-left">
                  <p className="text-navy">English</p>
                  <p className="text-xs text-muted-foreground mt-0.5">
                    United States
                  </p>
                </div>

                <div
                  className={`w-5 h-5 rounded-full border-2 flex items-center justify-center ${
                    selectedLanguage === "english"
                      ? "border-gold"
                      : "border-muted-foreground"
                  }`}
                >
                  {selectedLanguage === "english" && (
                    <div className="w-2.5 h-2.5 rounded-full bg-gold" />
                  )}
                </div>
              </button>

              {/* Indonesia */}
              <button
                onClick={() => {
                  setSelectedLanguage("indonesia");
                  setShowLanguageSheet(false);
                }}
                className={`w-full flex items-center gap-4 rounded-2xl border p-4 transition-all ${
                  selectedLanguage === "indonesia"
                    ? "border-gold bg-gold/5"
                    : "border-border bg-card"
                }`}
              >
                <div className="text-3xl">🇮🇩</div>

                <div className="flex-1 text-left">
                  <p className="text-navy">Bahasa Indonesia</p>
                  <p className="text-xs text-muted-foreground mt-0.5">
                    Indonesia
                  </p>
                </div>

                <div
                  className={`w-5 h-5 rounded-full border-2 flex items-center justify-center ${
                    selectedLanguage === "indonesia"
                      ? "border-gold"
                      : "border-muted-foreground"
                  }`}
                >
                  {selectedLanguage === "indonesia" && (
                    <div className="w-2.5 h-2.5 rounded-full bg-gold" />
                  )}
                </div>
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
import {
  User,
  Bell,
  Clock,
  Shield,
  Heart,
  ChevronRight,
  LogOut,
} from "lucide-react";
import { useState, useEffect } from "react";

interface SettingsScreenProps {
  onNavigate?: (screen: string) => void;
}

export default function SettingsScreen({
  onNavigate,
}: SettingsScreenProps) {
  const [notifications, setNotifications] = useState(true);
  const [dailyReminder, setDailyReminder] = useState(true);

  return (
    <div className="h-screen w-full bg-background overflow-y-auto pb-20">
      {/* Header */}
      <div className="bg-gradient-to-br from-navy to-[#0f1419] text-ivory p-6 pb-8 rounded-b-2xl shadow-lg">
        <h1 className="text-2xl mb-6">Settings</h1>

        {/* Profile section */}
        <div
          onClick={() => onNavigate?.("profile-settings")}
          className="bg-white/10 backdrop-blur-sm border border-white/20 rounded-2xl p-4 flex items-center gap-4 cursor-pointer hover:bg-white/15 transition-colors"
        >
          <div className="w-16 h-16 bg-gradient-to-br from-gold to-sunset rounded-full flex items-center justify-center text-2xl">
            S
          </div>
          <div className="flex-1">
            <h3 className="text-lg">Sarah Johnson</h3>
            <p className="text-beige/70 text-sm">
              sarah.j@email.com
            </p>
          </div>
        </div>
      </div>

      <div className="p-6 space-y-6">
        {/* Preferences */}
        <div className="space-y-3">
          <h3 className="text-sm text-muted-foreground px-2">
            Preferences
          </h3>

          <div className="bg-card border border-border rounded-2xl overflow-hidden shadow-sm">
            <button
              onClick={() =>
                onNavigate?.("additional-settings")
              }
              className="w-full p-4 flex items-center gap-4 hover:bg-muted/30 transition-colors border-b border-border"
            >
              <div className="bg-gold/10 p-2.5 rounded-xl">
                <User className="w-5 h-5 text-gold" />
              </div>

              <div className="flex-1 text-left">
                <p className="text-navy">
                  Spiritual Preferences
                </p>
                <p className="text-xs text-muted-foreground mt-0.5">
                  Personalization and reading settings
                </p>
              </div>

              <ChevronRight className="w-5 h-5 text-muted-foreground" />
            </button>

            <div className="p-4 flex items-center gap-4">
              <div className="bg-sunset/10 p-2.5 rounded-xl">
                <Bell className="w-5 h-5 text-sunset" />
              </div>
              <span className="flex-1 text-navy">
                Notifications
              </span>
              <label className="relative inline-flex items-center cursor-pointer">
                <input
                  type="checkbox"
                  checked={notifications}
                  onChange={(e) =>
                    setNotifications(e.target.checked)
                  }
                  className="sr-only peer"
                />
                <div className="w-11 h-6 bg-muted peer-focus:outline-none peer-focus:ring-2 peer-focus:ring-gold/50 rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-gradient-to-r peer-checked:from-gold peer-checked:to-sunset" />
              </label>
            </div>
          </div>
        </div>

        {/* Devotional Settings */}
        <div className="space-y-3">
          <h3 className="text-sm text-muted-foreground px-2">
            Devotional Settings
          </h3>

          <div className="bg-card border border-border rounded-2xl overflow-hidden shadow-sm">
            <div className="p-4 flex items-center gap-4 border-b border-border">
              <div className="bg-gold/10 p-2.5 rounded-xl">
                <Clock className="w-5 h-5 text-gold" />
              </div>
              <div className="flex-1">
                <p className="text-navy">Daily Reminder</p>
                <p className="text-xs text-muted-foreground mt-0.5">
                  8:00 AM every day
                </p>
              </div>
              <label className="relative inline-flex items-center cursor-pointer">
                <input
                  type="checkbox"
                  checked={dailyReminder}
                  onChange={(e) =>
                    setDailyReminder(e.target.checked)
                  }
                  className="sr-only peer"
                />
                <div className="w-11 h-6 bg-muted peer-focus:outline-none peer-focus:ring-2 peer-focus:ring-gold/50 rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-gradient-to-r peer-checked:from-gold peer-checked:to-sunset" />
              </label>
            </div>

            <button
              onClick={() => onNavigate?.("saved-devotionals")}
              className="w-full p-4 flex items-center gap-4 hover:bg-muted/30 transition-colors"
            >
              <div className="bg-sunset/10 p-2.5 rounded-xl">
                <Heart className="w-5 h-5 text-sunset" />
              </div>
              <span className="flex-1 text-left text-navy">
                Saved Devotionals
              </span>
              <ChevronRight className="w-5 h-5 text-muted-foreground" />
            </button>
          </div>
        </div>

        {/* Account & Legal */}
        <div className="space-y-3">
          <h3 className="text-sm text-muted-foreground px-2">
            Account & Legal
          </h3>

          <div className="bg-card border border-border rounded-2xl overflow-hidden shadow-sm">
            <button className="w-full p-4 flex items-center gap-4 hover:bg-muted/30 transition-colors border-b border-border">
              <span className="flex-1 text-left text-navy">
                Privacy & Security
              </span>
              <ChevronRight className="w-5 h-5 text-muted-foreground" />
            </button>

            <button className="w-full p-4 flex items-center gap-4 hover:bg-muted/30 transition-colors border-b border-border">
              <span className="flex-1 text-left text-navy">
                Terms of Service
              </span>
              <ChevronRight className="w-5 h-5 text-muted-foreground" />
            </button>

            <button className="w-full p-4 flex items-center gap-4 hover:bg-muted/30 transition-colors">
              <span className="flex-1 text-left text-navy">
                Privacy Policy
              </span>
              <ChevronRight className="w-5 h-5 text-muted-foreground" />
            </button>
          </div>
        </div>

        {/* App info */}
        <div className="bg-gradient-to-br from-gold/5 to-sunset/5 rounded-2xl p-5 border border-gold/20 text-center">
          <p className="text-sm text-navy mb-1">
            f<span className="text-gold">AI</span>th
          </p>
          <p className="text-xs text-muted-foreground">
            Version 1.0.0
          </p>
        </div>

        {/* Sign out */}
        <button className="w-full bg-destructive/10 text-destructive rounded-2xl p-4 flex items-center justify-center gap-2 hover:bg-destructive/20 transition-all">
          <LogOut className="w-5 h-5" />
          <span>Sign Out</span>
        </button>
      </div>
    </div>
  );
}
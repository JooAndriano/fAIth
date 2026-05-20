import { ChevronLeft, Camera, User, AlertTriangle, Star, Bell, Heart, Globe, ChevronRight } from "lucide-react";
import { useState } from "react";

interface ProfileSettingsScreenProps {
  onBack: () => void;
  onNavigate?: (screen: string) => void;
}

export default function ProfileSettingsScreen({ onBack, onNavigate }: ProfileSettingsScreenProps) {
  const [username, setUsername] = useState("Sarah Johnson");
  const [showDeleteConfirm, setShowDeleteConfirm] = useState(false);

  return (
    <div className="h-screen w-full bg-background overflow-y-auto pb-20">
      {/* Header */}
      <div className="bg-gradient-to-br from-navy to-[#0f1419] text-ivory p-6 pb-8">
        <div className="flex items-center gap-4">
          <button onClick={onBack} className="p-2 hover:bg-white/10 rounded-xl transition-colors">
            <ChevronLeft className="w-6 h-6" />
          </button>
          <h1 className="text-2xl">Profile Settings</h1>
        </div>
      </div>

      <div className="p-6 space-y-6">
        {/* Profile Photo */}
        <div className="space-y-3">
          <label className="text-sm text-muted-foreground">Profile Photo</label>
          <div className="flex items-center gap-4">
            <div className="w-24 h-24 bg-gradient-to-br from-gold to-sunset rounded-full flex items-center justify-center text-3xl text-ivory relative">
              S
              <div className="absolute inset-0 bg-black/40 rounded-full flex items-center justify-center opacity-0 hover:opacity-100 transition-opacity cursor-pointer">
                <Camera className="w-6 h-6 text-ivory" />
              </div>
            </div>
            <div className="flex-1">
              <button className="bg-card border border-border text-navy rounded-xl px-4 py-2.5 text-sm hover:border-gold transition-colors">
                Change Photo
              </button>
              <p className="text-xs text-muted-foreground mt-2">JPG, PNG or GIF. Max 2MB.</p>
            </div>
          </div>
        </div>

        {/* Username */}
        <div className="space-y-3">
          <label className="text-sm text-muted-foreground">Username</label>
          <div className="relative">
            <User className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground" />
            <input
              type="text"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              className="w-full bg-input-background border border-border rounded-2xl pl-12 pr-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-gold/50"
            />
          </div>
        </div>

        {/* Email (read-only) */}
        <div className="space-y-3">
          <label className="text-sm text-muted-foreground">Email</label>
          <div className="bg-muted/50 border border-border rounded-2xl px-4 py-3 text-sm text-muted-foreground">
            sarah.j@email.com
          </div>
          <p className="text-xs text-muted-foreground">Email cannot be changed</p>
        </div>

        {/* Save button */}
        <button className="w-full bg-gradient-to-br from-gold to-sunset text-ivory rounded-2xl p-4 shadow-lg hover:shadow-xl transition-all active:scale-98">
          Save Changes
        </button>

        {/* Additional Settings */}
        <div className="space-y-3 pt-6 border-t border-border">
          <h3 className="text-sm text-muted-foreground px-2">Personalization</h3>

          <div className="bg-card border border-border rounded-2xl overflow-hidden shadow-sm">
            <button
              onClick={() => onNavigate?.('favorite-verses')}
              className="w-full p-4 flex items-center gap-4 hover:bg-muted/30 transition-colors border-b border-border"
            >
              <div className="bg-gold/10 p-2.5 rounded-xl">
                <Star className="w-5 h-5 text-gold" />
              </div>
              <div className="flex-1 text-left">
                <p className="text-navy">Favorite Verses</p>
                <p className="text-xs text-muted-foreground mt-0.5">Manage daily encouragement verses</p>
              </div>
              <ChevronRight className="w-5 h-5 text-muted-foreground" />
            </button>

            <button className="w-full p-4 flex items-center gap-4 hover:bg-muted/30 transition-colors border-b border-border">
              <div className="bg-sunset/10 p-2.5 rounded-xl">
                <Bell className="w-5 h-5 text-sunset" />
              </div>
              <div className="flex-1 text-left">
                <p className="text-navy">Notification Preferences</p>
                <p className="text-xs text-muted-foreground mt-0.5">Customize your alerts and reminders</p>
              </div>
              <ChevronRight className="w-5 h-5 text-muted-foreground" />
            </button>

            <button className="w-full p-4 flex items-center gap-4 hover:bg-muted/30 transition-colors border-b border-border">
              <div className="bg-navy/10 p-2.5 rounded-xl">
                <Heart className="w-5 h-5 text-navy" />
              </div>
              <div className="flex-1 text-left">
                <p className="text-navy">Reading Preferences</p>
                <p className="text-xs text-muted-foreground mt-0.5">Bible version and font settings</p>
              </div>
              <ChevronRight className="w-5 h-5 text-muted-foreground" />
            </button>

            <button className="w-full p-4 flex items-center gap-4 hover:bg-muted/30 transition-colors">
              <div className="bg-gold/10 p-2.5 rounded-xl">
                <Globe className="w-5 h-5 text-gold" />
              </div>
              <div className="flex-1 text-left">
                <p className="text-navy">Language & Region</p>
                <p className="text-xs text-muted-foreground mt-0.5">App language and location settings</p>
              </div>
              <ChevronRight className="w-5 h-5 text-muted-foreground" />
            </button>
          </div>
        </div>

        {/* Danger Zone */}
        <div className="space-y-3 pt-6 border-t border-border">
          <div className="flex items-center gap-2">
            <AlertTriangle className="w-5 h-5 text-destructive" />
            <h3 className="text-navy">Danger Zone</h3>
          </div>

          <div className="bg-destructive/5 border border-destructive/20 rounded-2xl p-5 space-y-3">
            <div>
              <h4 className="text-sm text-navy mb-1">Delete Account</h4>
              <p className="text-xs text-muted-foreground">
                Once you delete your account, there is no going back. All your prayers, devotionals, and data will be permanently deleted.
              </p>
            </div>

            {!showDeleteConfirm ? (
              <button
                onClick={() => setShowDeleteConfirm(true)}
                className="w-full bg-destructive/10 text-destructive rounded-xl p-3 hover:bg-destructive/20 transition-all"
              >
                Delete Account
              </button>
            ) : (
              <div className="space-y-2">
                <p className="text-sm text-destructive">Are you absolutely sure?</p>
                <div className="flex gap-2">
                  <button
                    onClick={() => setShowDeleteConfirm(false)}
                    className="flex-1 bg-muted text-muted-foreground rounded-xl p-3 hover:bg-muted/80 transition-all"
                  >
                    Cancel
                  </button>
                  <button
                    onClick={() => alert("Account deleted (demo)")}
                    className="flex-1 bg-destructive text-white rounded-xl p-3 hover:bg-destructive/90 transition-all"
                  >
                    Yes, Delete
                  </button>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

import { Plus, Heart, CheckCircle2, Clock, ChevronRight } from "lucide-react";
import { useState } from "react";
import PrayerBottomSheet from "./PrayerBottomSheet";

interface PrayerJournalScreenProps {
  onNavigate?: (screen: string) => void;
}

export default function PrayerJournalScreen({ onNavigate }: PrayerJournalScreenProps) {
  const [showNewPrayer, setShowNewPrayer] = useState(false);
  const [newPrayer, setNewPrayer] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("");
  const [selectedPrayer, setSelectedPrayer] = useState<any>(null);

  const categories = [
    "Health",
    "Family",
    "Guidance",
    "Finance",
    "Friends",
    "Church",
    "Personal",
    "Mission",
    "Other"
  ];

  const prayers = [
    {
      id: 1,
      title: "Guidance for career decision",
      date: "May 17, 2026",
      category: "Guidance",
      answered: false,
    },
    {
      id: 2,
      title: "Healing for mom's surgery",
      date: "May 15, 2026",
      category: "Health",
      answered: true,
    },
    {
      id: 3,
      title: "Peace in family relationships",
      date: "May 12, 2026",
      category: "Family",
      answered: false,
    },
  ];

  return (
    <div className="h-screen w-full bg-background overflow-y-auto pb-20">
      {/* Header */}
      <div className="bg-gradient-to-br from-navy to-[#0f1419] text-ivory p-6 pb-8 rounded-b-2xl shadow-lg">
        <div className="flex items-center justify-between mb-2">
          <h1 className="text-2xl">Prayer Journal</h1>
          <button
            onClick={() => setShowNewPrayer(!showNewPrayer)}
            className="bg-gradient-to-br from-gold to-sunset text-ivory p-3 rounded-full hover:shadow-lg transition-all active:scale-95"
          >
            <Plus className="w-5 h-5" />
          </button>
        </div>
        <p className="text-beige/70 text-sm">Your private space with God</p>
      </div>

      <div className="p-6 space-y-6">
        {/* Stats */}
        <div className="grid grid-cols-2 gap-4">
          <div className="bg-card border border-border rounded-2xl p-4 shadow-sm">
            <div className="flex items-center gap-2 mb-2">
              <Clock className="w-4 h-4 text-gold" />
              <span className="text-xs text-muted-foreground">Active</span>
            </div>
            <p className="text-2xl text-navy">12</p>
          </div>
          <div className="bg-gradient-to-br from-gold/10 to-sunset/10 border border-gold/20 rounded-2xl p-4">
            <div className="flex items-center gap-2 mb-2">
              <CheckCircle2 className="w-4 h-4 text-gold" />
              <span className="text-xs text-gold">Answered</span>
            </div>
            <p className="text-2xl text-navy">28</p>
          </div>
        </div>

        {/* New prayer form */}
        {showNewPrayer && (
          <div className="bg-card border-2 border-gold/30 rounded-2xl p-5 space-y-4 shadow-lg">
            <h3 className="text-navy">New Prayer Request</h3>
            <textarea
              value={newPrayer}
              onChange={(e) => setNewPrayer(e.target.value)}
              placeholder="Share your prayer with God..."
              className="w-full bg-input-background rounded-xl p-4 text-sm focus:outline-none focus:ring-2 focus:ring-gold/50 min-h-[120px] resize-none"
            />

            {/* Category selection */}
            <div className="space-y-2">
              <label className="text-sm text-muted-foreground">Category</label>
              <div className="flex flex-wrap gap-2">
                {categories.map((category) => (
                  <button
                    key={category}
                    onClick={() => setSelectedCategory(category)}
                    className={`px-3 py-1.5 rounded-xl text-sm transition-all ${
                      selectedCategory === category
                        ? "bg-gradient-to-br from-gold to-sunset text-ivory"
                        : "bg-muted text-muted-foreground hover:bg-muted/80"
                    }`}
                  >
                    {category}
                  </button>
                ))}
              </div>
            </div>

            <div className="flex gap-2">
              <button
                onClick={() => {
                  setNewPrayer("");
                  setSelectedCategory("");
                  setShowNewPrayer(false);
                }}
                className="flex-1 bg-muted text-muted-foreground rounded-xl p-3 hover:bg-muted/80 transition-all"
              >
                Cancel
              </button>
              <button className="flex-1 bg-gradient-to-br from-gold to-sunset text-ivory rounded-xl p-3 hover:shadow-lg transition-all active:scale-98">
                Save Prayer
              </button>
            </div>
          </div>
        )}

        {/* Prayers list */}
        <div className="space-y-4">
          <div className="flex items-center justify-between">
            <h3 className="text-navy">Recent Prayers</h3>
            <button
              onClick={() => onNavigate?.('all-prayers')}
              className="text-sm text-gold flex items-center gap-1"
            >
              View all <ChevronRight className="w-4 h-4" />
            </button>
          </div>

          <div className="space-y-3">
            {prayers.map((prayer) => (
              <div
                key={prayer.id}
                onClick={() => setSelectedPrayer(prayer)}
                className={`bg-card border rounded-2xl p-5 shadow-sm hover:shadow-md transition-all cursor-pointer ${
                  prayer.answered ? "border-gold/30 bg-gradient-to-br from-gold/5 to-transparent" : "border-border"
                }`}
              >
                <div className="flex items-start justify-between gap-3">
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-2">
                      {prayer.answered ? (
                        <CheckCircle2 className="w-4 h-4 text-gold flex-shrink-0" />
                      ) : (
                        <Clock className="w-4 h-4 text-muted-foreground flex-shrink-0" />
                      )}
                      <span className={`text-xs ${prayer.answered ? "text-gold" : "text-muted-foreground"}`}>
                        {prayer.answered ? "Answered" : "In prayer"}
                      </span>
                    </div>
                    <h4 className="text-navy mb-1">{prayer.title}</h4>
                    <div className="flex items-center gap-2 text-xs text-muted-foreground">
                      <span>{prayer.date}</span>
                      <span>•</span>
                      <span className="bg-muted px-2 py-1 rounded-lg">{prayer.category}</span>
                    </div>
                  </div>
                  <ChevronRight className="w-5 h-5 text-muted-foreground flex-shrink-0 mt-1" />
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Encouragement */}
        <div className="bg-gradient-to-br from-sunset/10 to-gold/10 rounded-2xl p-5 border border-sunset/20">
          <div className="flex items-start gap-3">
            <Heart className="w-5 h-5 text-sunset flex-shrink-0 mt-0.5" />
            <div>
              <p className="text-sm text-navy leading-relaxed italic">
                "Do not be anxious about anything, but in every situation, by prayer and petition, with thanksgiving, present your requests to God."
              </p>
              <p className="text-xs text-sunset mt-2">Philippians 4:6</p>
            </div>
          </div>
        </div>
      </div>

      {/* Bottom sheet */}
      {selectedPrayer && (
        <PrayerBottomSheet
          prayer={selectedPrayer}
          onClose={() => setSelectedPrayer(null)}
          onEdit={() => {
            setSelectedPrayer(null);
            alert("Edit prayer (to be implemented)");
          }}
          onDelete={() => {
            setSelectedPrayer(null);
            alert("Delete prayer (to be implemented)");
          }}
          onToggleStatus={() => {
            setSelectedPrayer(null);
            alert("Toggle status (to be implemented)");
          }}
        />
      )}
    </div>
  );
}

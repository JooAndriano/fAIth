import { ChevronLeft, CheckCircle2, Clock, ChevronRight, Search } from "lucide-react";
import { useState } from "react";

interface AllPrayersScreenProps {
  onBack: () => void;
  onPrayerClick: (prayer: any) => void;
}

export default function AllPrayersScreen({ onBack, onPrayerClick }: AllPrayersScreenProps) {
  const [filter, setFilter] = useState<"all" | "active" | "answered">("all");
  const [searchQuery, setSearchQuery] = useState("");

  const allPrayers = [
    { id: 1, title: "Guidance for career decision", date: "May 17, 2026", category: "Guidance", answered: false },
    { id: 2, title: "Healing for mom's surgery", date: "May 15, 2026", category: "Health", answered: true },
    { id: 3, title: "Peace in family relationships", date: "May 12, 2026", category: "Family", answered: false },
    { id: 4, title: "Strength during difficult times", date: "May 10, 2026", category: "Personal", answered: false },
    { id: 5, title: "Friend's job interview", date: "May 8, 2026", category: "Friends", answered: true },
    { id: 6, title: "Financial provision", date: "May 5, 2026", category: "Finance", answered: false },
    { id: 7, title: "Church community growth", date: "May 3, 2026", category: "Church", answered: false },
    { id: 8, title: "Wisdom in parenting", date: "May 1, 2026", category: "Family", answered: true },
    { id: 9, title: "Health and wellness", date: "Apr 28, 2026", category: "Health", answered: false },
    { id: 10, title: "Mission trip preparation", date: "Apr 25, 2026", category: "Mission", answered: true },
  ];

  const filteredPrayers = allPrayers.filter(prayer => {
    const matchesFilter = filter === "all" ||
      (filter === "answered" && prayer.answered) ||
      (filter === "active" && !prayer.answered);
    const matchesSearch = prayer.title.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesFilter && matchesSearch;
  });

  return (
    <div className="h-screen w-full bg-background overflow-y-auto pb-20">
      {/* Header */}
      <div className="bg-gradient-to-br from-navy to-[#0f1419] text-ivory p-6 pb-8 sticky top-0 z-10">
        <div className="flex items-center gap-4 mb-4">
          <button onClick={onBack} className="p-2 hover:bg-white/10 rounded-xl transition-colors">
            <ChevronLeft className="w-6 h-6" />
          </button>
          <h1 className="text-2xl">All Prayers</h1>
        </div>

        {/* Search */}
        <div className="relative">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-beige/50" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search prayers..."
            className="w-full bg-white/10 backdrop-blur-sm border border-white/20 rounded-2xl pl-12 pr-4 py-3 text-sm placeholder:text-beige/50 focus:outline-none focus:ring-2 focus:ring-gold/50"
          />
        </div>
      </div>

      <div className="p-6 space-y-6">
        {/* Filter tabs */}
        <div className="flex gap-2 overflow-x-auto pb-2">
          <button
            onClick={() => setFilter("all")}
            className={`px-4 py-2 rounded-xl text-sm whitespace-nowrap transition-all ${
              filter === "all"
                ? "bg-navy text-ivory shadow-sm"
                : "bg-card border border-border text-navy hover:border-gold"
            }`}
          >
            All ({allPrayers.length})
          </button>
          <button
            onClick={() => setFilter("active")}
            className={`px-4 py-2 rounded-xl text-sm whitespace-nowrap transition-all ${
              filter === "active"
                ? "bg-navy text-ivory shadow-sm"
                : "bg-card border border-border text-navy hover:border-gold"
            }`}
          >
            Active ({allPrayers.filter(p => !p.answered).length})
          </button>
          <button
            onClick={() => setFilter("answered")}
            className={`px-4 py-2 rounded-xl text-sm whitespace-nowrap transition-all ${
              filter === "answered"
                ? "bg-navy text-ivory shadow-sm"
                : "bg-card border border-border text-navy hover:border-gold"
            }`}
          >
            Answered ({allPrayers.filter(p => p.answered).length})
          </button>
        </div>

        {/* Prayers list */}
        <div className="space-y-3">
          {filteredPrayers.map((prayer) => (
            <div
              key={prayer.id}
              onClick={() => onPrayerClick(prayer)}
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

        {filteredPrayers.length === 0 && (
          <div className="text-center py-12">
            <p className="text-muted-foreground">No prayers found</p>
          </div>
        )}
      </div>
    </div>
  );
}

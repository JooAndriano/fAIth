import { ChevronLeft, Bookmark, Calendar, ChevronRight } from "lucide-react";

interface SavedDevotionalsScreenProps {
  onBack: () => void;
  onDevotionalClick?: () => void;
}

export default function SavedDevotionalsScreen({ onBack, onDevotionalClick }: SavedDevotionalsScreenProps) {
  const savedDevotionals = [
    {
      id: 1,
      title: "Finding Peace in Uncertainty",
      verse: "John 14:27",
      date: "May 18, 2026",
      category: "Peace",
    },
    {
      id: 2,
      title: "Walking by Faith",
      verse: "2 Corinthians 5:7",
      date: "May 15, 2026",
      category: "Faith",
    },
    {
      id: 3,
      title: "God's Unfailing Love",
      verse: "Psalm 136:1",
      date: "May 12, 2026",
      category: "Love",
    },
    {
      id: 4,
      title: "Strength in Weakness",
      verse: "2 Corinthians 12:9",
      date: "May 10, 2026",
      category: "Strength",
    },
    {
      id: 5,
      title: "The Joy of the Lord",
      verse: "Nehemiah 8:10",
      date: "May 8, 2026",
      category: "Joy",
    },
    {
      id: 6,
      title: "Trusting God's Timing",
      verse: "Ecclesiastes 3:11",
      date: "May 5, 2026",
      category: "Trust",
    },
  ];

  return (
    <div className="h-screen w-full bg-background overflow-y-auto pb-20">
      {/* Header */}
      <div className="bg-gradient-to-br from-navy to-[#0f1419] text-ivory p-6 pb-8">
        <div className="flex items-center gap-4 mb-2">
          <button onClick={onBack} className="p-2 hover:bg-white/10 rounded-xl transition-colors">
            <ChevronLeft className="w-6 h-6" />
          </button>
          <h1 className="text-2xl">Saved Devotionals</h1>
        </div>
        <p className="text-beige/70 text-sm">Your favorite devotionals</p>
      </div>

      <div className="p-6 space-y-4">
        {/* Stats */}
        <div className="bg-gradient-to-br from-gold/10 to-sunset/10 rounded-2xl p-5 border border-gold/20">
          <div className="flex items-center gap-2 mb-2">
            <Bookmark className="w-5 h-5 text-gold" />
            <span className="text-sm text-gold">Total Saved</span>
          </div>
          <p className="text-3xl text-navy">{savedDevotionals.length}</p>
        </div>

        {/* Devotionals list */}
        <div className="space-y-3">
          {savedDevotionals.map((devotional) => (
            <div
              key={devotional.id}
              onClick={onDevotionalClick}
              className="bg-card border border-border rounded-2xl p-5 shadow-sm hover:shadow-md transition-all cursor-pointer"
            >
              <div className="flex items-start justify-between gap-3">
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-2">
                    <span className="text-xs bg-gold/10 text-gold px-2 py-1 rounded-lg">
                      {devotional.category}
                    </span>
                    <Bookmark className="w-3.5 h-3.5 text-gold fill-gold" />
                  </div>
                  <h4 className="text-navy mb-2">{devotional.title}</h4>
                  <div className="flex items-center gap-3 text-xs text-muted-foreground">
                    <span className="flex items-center gap-1">
                      <Calendar className="w-3.5 h-3.5" />
                      {devotional.date}
                    </span>
                    <span>•</span>
                    <span className="text-gold">{devotional.verse}</span>
                  </div>
                </div>
                <ChevronRight className="w-5 h-5 text-muted-foreground flex-shrink-0 mt-1" />
              </div>
            </div>
          ))}
        </div>

        {savedDevotionals.length === 0 && (
          <div className="text-center py-12">
            <Bookmark className="w-12 h-12 text-muted-foreground mx-auto mb-3" />
            <p className="text-muted-foreground">No saved devotionals yet</p>
            <p className="text-sm text-muted-foreground mt-1">
              Tap the bookmark icon on any devotional to save it
            </p>
          </div>
        )}
      </div>
    </div>
  );
}

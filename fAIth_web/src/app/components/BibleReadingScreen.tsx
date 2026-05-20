import { ChevronLeft, Bookmark, Share2, ChevronRight } from "lucide-react";

interface BibleReadingScreenProps {
  onBack: () => void;
}

export default function BibleReadingScreen({ onBack }: BibleReadingScreenProps) {
  return (
    <div className="h-screen w-full bg-background overflow-y-auto">
      {/* Header */}
      <div className="bg-gradient-to-br from-navy to-[#0f1419] text-ivory p-6 pb-8">
        <div className="flex items-center justify-between mb-4">
          <button onClick={onBack} className="p-2 hover:bg-white/10 rounded-xl transition-colors">
            <ChevronLeft className="w-6 h-6" />
          </button>
          <div className="flex items-center gap-3">
            <button className="p-2 hover:bg-white/10 rounded-xl transition-colors">
              <Share2 className="w-5 h-5" />
            </button>
            <button className="p-2 hover:bg-white/10 rounded-xl transition-colors">
              <Bookmark className="w-5 h-5" />
            </button>
          </div>
        </div>
        <div className="space-y-2">
          <span className="text-xs text-gold">Today's Reading</span>
          <h1 className="text-2xl">Psalm 23</h1>
          <p className="text-beige/70 text-sm">The Lord is My Shepherd</p>
        </div>
      </div>

      <div className="p-6 space-y-6 pb-24">
        {/* Scripture verses */}
        <div className="space-y-4">
          <div className="flex items-start gap-3">
            <span className="text-sm text-gold flex-shrink-0 w-6">1</span>
            <p className="text-navy leading-relaxed">
              The Lord is my shepherd, I lack nothing.
            </p>
          </div>

          <div className="flex items-start gap-3">
            <span className="text-sm text-gold flex-shrink-0 w-6">2</span>
            <p className="text-navy leading-relaxed">
              He makes me lie down in green pastures, he leads me beside quiet waters,
            </p>
          </div>

          <div className="flex items-start gap-3">
            <span className="text-sm text-gold flex-shrink-0 w-6">3</span>
            <p className="text-navy leading-relaxed">
              he refreshes my soul. He guides me along the right paths for his name's sake.
            </p>
          </div>

          <div className="flex items-start gap-3">
            <span className="text-sm text-gold flex-shrink-0 w-6">4</span>
            <p className="text-navy leading-relaxed">
              Even though I walk through the darkest valley, I will fear no evil, for you are with me; your rod and your staff, they comfort me.
            </p>
          </div>

          <div className="flex items-start gap-3">
            <span className="text-sm text-gold flex-shrink-0 w-6">5</span>
            <p className="text-navy leading-relaxed">
              You prepare a table before me in the presence of my enemies. You anoint my head with oil; my cup overflows.
            </p>
          </div>

          <div className="flex items-start gap-3">
            <span className="text-sm text-gold flex-shrink-0 w-6">6</span>
            <p className="text-navy leading-relaxed">
              Surely your goodness and love will follow me all the days of my life, and I will dwell in the house of the Lord forever.
            </p>
          </div>
        </div>

        {/* Navigation */}
        <div className="flex gap-3">
          <button className="flex-1 bg-card border border-border rounded-2xl p-4 hover:border-gold transition-colors flex items-center justify-center gap-2">
            <ChevronLeft className="w-4 h-4 text-muted-foreground" />
            <span className="text-sm text-navy">Psalm 22</span>
          </button>
          <button className="flex-1 bg-card border border-border rounded-2xl p-4 hover:border-gold transition-colors flex items-center justify-center gap-2">
            <span className="text-sm text-navy">Psalm 24</span>
            <ChevronRight className="w-4 h-4 text-muted-foreground" />
          </button>
        </div>
      </div>
    </div>
  );
}

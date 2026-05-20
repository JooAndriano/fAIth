import { Bookmark, Share2, Heart, ChevronLeft } from "lucide-react";

interface DevotionalScreenProps {
  onBack: () => void;
}

export default function DevotionalScreen({ onBack }: DevotionalScreenProps) {
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
          <span className="text-xs text-gold">May 18, 2026 • Today's Devotional</span>
          <h1 className="text-2xl leading-tight">Finding Peace in Uncertainty</h1>
        </div>
      </div>

      <div className="p-6 space-y-6 pb-24">
        {/* Verse highlight */}
        <div className="bg-gradient-to-br from-gold/10 to-sunset/10 rounded-2xl p-6 border border-gold/20">
          <p className="text-navy leading-relaxed italic mb-3">
            "Peace I leave with you; my peace I give you. I do not give to you as the world gives. Do not let your hearts be troubled and do not be afraid."
          </p>
          <p className="text-sm text-gold">John 14:27</p>
        </div>

        {/* Reflection */}
        <div className="space-y-4">
          <h3 className="text-navy">Reflection</h3>
          <p className="text-muted-foreground leading-relaxed">
            In a world filled with constant change and uncertainty, finding peace can seem impossible. Yet Jesus offers us a different kind of peace—not the temporary calm that depends on circumstances, but a deep, abiding peace that comes from knowing God is in control.
          </p>
          <p className="text-muted-foreground leading-relaxed">
            This peace isn't about the absence of storms in our lives. Rather, it's about having confidence that even in the midst of life's turbulence, we are held by a loving Father who has already overcome the world.
          </p>
          <p className="text-muted-foreground leading-relaxed">
            When anxiety threatens to overwhelm you, remember that God's peace is available. Take a moment to breathe deeply, to pray, and to rest in His presence. He is with you, and His peace surpasses all understanding.
          </p>
        </div>

        {/* Prayer section */}
        <div className="bg-card border border-border rounded-2xl p-6 space-y-3">
          <h3 className="text-navy">Prayer</h3>
          <p className="text-muted-foreground leading-relaxed italic">
            "Dear Heavenly Father, thank you for the gift of your peace. Help me to trust in you completely, especially when life feels uncertain. Calm my anxious heart and remind me that you are always in control. Fill me with your peace that surpasses all understanding. In Jesus' name, Amen."
          </p>
        </div>

        {/* Action step */}
        <div className="bg-gradient-to-br from-sunset/10 to-gold/10 rounded-2xl p-5 border border-sunset/20">
          <h4 className="text-sm text-sunset mb-2">Today's Challenge</h4>
          <p className="text-navy text-sm leading-relaxed">
            Set aside 5 minutes today to sit in silence and simply be present with God. When worries arise, gently redirect your thoughts back to His peace.
          </p>
        </div>

        {/* Save button */}
        <button className="w-full bg-gradient-to-br from-gold to-sunset text-ivory rounded-2xl p-4 shadow-lg hover:shadow-xl transition-all active:scale-98 flex items-center justify-center gap-2">
          <Heart className="w-5 h-5" />
          <span>Save to Favorites</span>
        </button>
      </div>
    </div>
  );
}

import { Search, Book, History, Link2, ChevronRight } from "lucide-react";
import { useState } from "react";

interface BibleStudyScreenProps {
  onNavigate?: (screen: string) => void;
}

export default function BibleStudyScreen({ onNavigate }: BibleStudyScreenProps) {
  const [searchQuery, setSearchQuery] = useState("");

  return (
    <div className="h-screen w-full bg-background overflow-y-auto pb-20">
      {/* Header */}
      <div className="bg-gradient-to-br from-navy to-[#0f1419] text-ivory p-6 pb-8 rounded-b-2xl shadow-lg">
        <h1 className="text-2xl mb-6">Bible Study</h1>

        {/* Search */}
        <div className="relative">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-beige/50" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search scripture or topic..."
            className="w-full bg-white/10 backdrop-blur-sm border border-white/20 rounded-2xl pl-12 pr-4 py-3 text-sm placeholder:text-beige/50 focus:outline-none focus:ring-2 focus:ring-gold/50"
          />
        </div>
      </div>

      <div className="p-6 space-y-6">
        {/* Today's Reading */}
        <div className="bg-gradient-to-br from-gold/10 to-sunset/10 rounded-2xl p-5 border border-gold/20">
          <div className="flex items-center gap-2 mb-3">
            <Book className="w-5 h-5 text-gold" />
            <span className="text-sm text-gold">Today's Reading</span>
          </div>
          <h3 className="text-navy mb-2">Psalm 23</h3>
          <p className="text-sm text-muted-foreground mb-4">
            The Lord is my shepherd; I shall not want...
          </p>
          <button
            onClick={() => onNavigate?.('bible-reading')}
            className="text-sm text-gold flex items-center gap-1 hover:gap-2 transition-all"
          >
            Continue reading <ChevronRight className="w-4 h-4" />
          </button>
        </div>

        {/* Scripture with context */}
        <div className="space-y-4">
          <h3 className="text-navy">Featured Study</h3>

          <div className="bg-card border border-border rounded-2xl p-5 space-y-4 shadow-sm">
            <div className="flex items-start justify-between">
              <div>
                <h4 className="text-navy mb-1">The Good Shepherd</h4>
                <p className="text-xs text-gold">John 10:11-18</p>
              </div>
            </div>

            <div className="bg-gradient-to-br from-gold/5 to-sunset/5 rounded-xl p-4 border-l-4 border-gold">
              <p className="text-sm text-navy leading-relaxed">
                "I am the good shepherd. The good shepherd lays down his life for the sheep."
              </p>
            </div>

            {/* Context */}
            <div className="space-y-3">
              <div className="flex items-start gap-3">
                <div className="bg-sunset/10 p-2 rounded-lg">
                  <History className="w-4 h-4 text-sunset" />
                </div>
                <div className="flex-1">
                  <h5 className="text-sm text-navy mb-1">Historical Context</h5>
                  <p className="text-xs text-muted-foreground leading-relaxed">
                    Shepherding was a common occupation in ancient Israel. Jesus used this familiar imagery to describe His relationship with believers.
                  </p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <div className="bg-gold/10 p-2 rounded-lg">
                  <Book className="w-4 h-4 text-gold" />
                </div>
                <div className="flex-1">
                  <h5 className="text-sm text-navy mb-1">Meaning</h5>
                  <p className="text-xs text-muted-foreground leading-relaxed">
                    Jesus contrasts Himself with hired hands who abandon sheep in danger. He willingly sacrifices Himself for those He loves.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Cross references */}
        <div className="bg-card border border-border rounded-2xl p-5 space-y-4">
          <div className="flex items-center gap-2">
            <Link2 className="w-4 h-4 text-gold" />
            <h4 className="text-sm text-navy">Related Passages</h4>
          </div>

          <div className="space-y-3">
            <div
              onClick={() => onNavigate?.('bible-reading')}
              className="flex items-start gap-3 p-3 bg-muted/30 rounded-xl cursor-pointer hover:bg-muted/50 transition-colors"
            >
              <div className="flex-1">
                <p className="text-sm text-navy mb-1">Psalm 23</p>
                <p className="text-xs text-muted-foreground line-clamp-1">
                  The Lord is my shepherd, I lack nothing...
                </p>
              </div>
              <ChevronRight className="w-4 h-4 text-muted-foreground flex-shrink-0 mt-1" />
            </div>

            <div
              onClick={() => onNavigate?.('bible-reading')}
              className="flex items-start gap-3 p-3 bg-muted/30 rounded-xl cursor-pointer hover:bg-muted/50 transition-colors"
            >
              <div className="flex-1">
                <p className="text-sm text-navy mb-1">Ezekiel 34:11-16</p>
                <p className="text-xs text-muted-foreground line-clamp-1">
                  I myself will search for my sheep and look after them...
                </p>
              </div>
              <ChevronRight className="w-4 h-4 text-muted-foreground flex-shrink-0 mt-1" />
            </div>

            <div
              onClick={() => onNavigate?.('bible-reading')}
              className="flex items-start gap-3 p-3 bg-muted/30 rounded-xl cursor-pointer hover:bg-muted/50 transition-colors"
            >
              <div className="flex-1">
                <p className="text-sm text-navy mb-1">1 Peter 2:25</p>
                <p className="text-xs text-muted-foreground line-clamp-1">
                  For you were like sheep going astray...
                </p>
              </div>
              <ChevronRight className="w-4 h-4 text-muted-foreground flex-shrink-0 mt-1" />
            </div>
          </div>
        </div>

        {/* Timeline visualization */}
        <div className="bg-gradient-to-br from-navy/5 to-navy/10 rounded-2xl p-5 border border-navy/20">
          <h4 className="text-sm text-navy mb-4">Biblical Timeline</h4>
          <div className="relative">
            <div className="absolute left-4 top-0 bottom-0 w-0.5 bg-gold/30" />
            <div className="space-y-4 relative">
              <div className="flex gap-4">
                <div className="w-8 h-8 bg-gold rounded-full flex items-center justify-center text-xs text-navy z-10 flex-shrink-0">
                  OT
                </div>
                <div className="flex-1 pb-4">
                  <p className="text-sm text-navy">Shepherds in Old Testament</p>
                  <p className="text-xs text-muted-foreground mt-1">Moses, David, and prophetic imagery</p>
                </div>
              </div>
              <div className="flex gap-4">
                <div className="w-8 h-8 bg-sunset rounded-full flex items-center justify-center text-xs text-ivory z-10 flex-shrink-0">
                  NT
                </div>
                <div className="flex-1">
                  <p className="text-sm text-navy">Jesus as the Good Shepherd</p>
                  <p className="text-xs text-muted-foreground mt-1">Fulfillment of prophecy, ~30 AD</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

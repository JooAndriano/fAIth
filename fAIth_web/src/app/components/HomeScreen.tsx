import { BookOpen, MessageCircle, PenLine, MapPin, Sparkles, ChevronRight } from "lucide-react";
import faithIcon from "../../imports/faith-icon.png";

interface HomeScreenProps {
  onNavigate: (screen: string) => void;
}

export default function HomeScreen({ onNavigate }: HomeScreenProps) {
  return (
    <div className="h-screen w-full bg-background overflow-y-auto pb-20">
      {/* Header */}
      <div className="bg-gradient-to-br from-navy via-navy to-[#0f1419] text-ivory p-6 pb-8 rounded-b-3xl shadow-lg">
        <div className="flex items-center justify-between mb-6">
          <div>
            <p className="text-beige/70 text-sm">Good morning,</p>
            <h1 className="text-2xl mt-1">Sarah</h1>
          </div>
          <img src={faithIcon} alt="Profile" className="w-12 h-12 rounded-full border-2 border-white/20" />
        </div>

        {/* Daily encouragement */}
        <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-4 border border-white/20">
          <p className="text-sm text-beige/80 italic">
            "The Lord is my strength and my shield; my heart trusts in him, and he helps me."
          </p>
          <p className="text-xs text-gold mt-2">Psalm 28:7</p>
        </div>
      </div>

      <div className="p-6 space-y-6">
        {/* Verse of the Day */}
        <div className="bg-gradient-to-br from-gold/10 to-sunset/10 rounded-2xl p-6 border border-gold/20 shadow-sm">
          <div className="flex items-center gap-2 mb-3">
            <BookOpen className="w-5 h-5 text-gold" />
            <h3 className="text-sm text-muted-foreground">Verse of the Day</h3>
          </div>
          <p className="text-navy leading-relaxed mb-2">
            "For I know the plans I have for you," declares the Lord, "plans to prosper you and not to harm you, plans to give you hope and a future."
          </p>
          <p className="text-sm text-gold">Jeremiah 29:11</p>
        </div>

        {/* Daily Devotional */}
        <div
          onClick={() => onNavigate('devotional')}
          className="bg-card rounded-2xl p-5 shadow-md border border-border hover:shadow-lg transition-all active:scale-98 cursor-pointer"
        >
          <div className="flex items-start justify-between">
            <div className="flex-1">
              <div className="flex items-center gap-2 mb-2">
                <Sparkles className="w-4 h-4 text-sunset" />
                <span className="text-xs text-sunset">Today's Devotional</span>
              </div>
              <h3 className="text-navy mb-1">Finding Peace in Uncertainty</h3>
              <p className="text-sm text-muted-foreground line-clamp-2">
                Discover how God's presence can bring calm to life's storms...
              </p>
            </div>
            <ChevronRight className="w-5 h-5 text-muted-foreground ml-2 flex-shrink-0" />
          </div>
        </div>

        {/* Quick Actions */}
        <div className="grid grid-cols-2 gap-4">
          <button
            onClick={() => onNavigate('chat')}
            className="bg-gradient-to-br from-navy to-[#0f1419] text-ivory rounded-2xl p-5 shadow-md hover:shadow-lg transition-all active:scale-98 flex flex-col items-start gap-3"
          >
            <div className="bg-gold/20 p-3 rounded-xl">
              <MessageCircle className="w-6 h-6 text-gold" />
            </div>
            <div className="text-left">
              <h4 className="text-sm mb-1">Ask fAIth</h4>
              <p className="text-xs text-beige/70">Chat with AI</p>
            </div>
          </button>

          <button
            onClick={() => onNavigate('prayer')}
            className="bg-card border border-border rounded-2xl p-5 shadow-md hover:shadow-lg transition-all active:scale-98 flex flex-col items-start gap-3"
          >
            <div className="bg-sunset/10 p-3 rounded-xl">
              <PenLine className="w-6 h-6 text-sunset" />
            </div>
            <div className="text-left">
              <h4 className="text-sm text-navy mb-1">Prayer Journal</h4>
              <p className="text-xs text-muted-foreground">Write prayer</p>
            </div>
          </button>
        </div>

        {/* Nearby Churches */}
        <div
          onClick={() => onNavigate('churches')}
          className="bg-card rounded-2xl p-5 shadow-md border border-border hover:shadow-lg transition-all active:scale-98 cursor-pointer"
        >
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-2">
              <MapPin className="w-5 h-5 text-gold" />
              <h3 className="text-navy">Nearby Churches</h3>
            </div>
            <ChevronRight className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="space-y-3">
            <div className="flex items-start gap-3">
              <div className="w-12 h-12 bg-gradient-to-br from-gold/20 to-sunset/20 rounded-xl flex-shrink-0" />
              <div className="flex-1 min-w-0">
                <h4 className="text-sm text-navy truncate">Grace Community Church</h4>
                <p className="text-xs text-muted-foreground">0.8 miles • Non-denominational</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

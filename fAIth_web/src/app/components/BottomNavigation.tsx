import { Home, MessageCircle, BookOpen, PenLine, Settings } from "lucide-react";

interface BottomNavigationProps {
  activeScreen: string;
  onNavigate: (screen: string) => void;
}

export default function BottomNavigation({ activeScreen, onNavigate }: BottomNavigationProps) {
  const navItems = [
    { id: "home", label: "Home", icon: Home },
    { id: "chat", label: "Ask fAIth", icon: MessageCircle },
    { id: "bible", label: "Bible", icon: BookOpen },
    { id: "prayer", label: "Prayer", icon: PenLine },
    { id: "settings", label: "Settings", icon: Settings },
  ];

  return (
    <div className="fixed bottom-0 left-0 right-0 bg-card border-t border-border shadow-2xl z-50">
      <div className="max-w-md mx-auto flex items-center justify-around px-2 py-2 safe-area-inset-bottom">
        {navItems.map((item) => {
          const Icon = item.icon;
          const isActive = activeScreen === item.id;

          return (
            <button
              key={item.id}
              onClick={() => onNavigate(item.id)}
              className={`flex-1 flex flex-col items-center gap-1 py-2 px-1 rounded-xl transition-all ${
                isActive
                  ? "text-gold"
                  : "text-muted-foreground hover:text-navy"
              }`}
            >
              <div className={`relative ${isActive ? "scale-110" : ""} transition-transform`}>
                <Icon className="w-6 h-6" strokeWidth={isActive ? 2.5 : 2} />
                {isActive && (
                  <div className="absolute -bottom-1 left-1/2 -translate-x-1/2 w-1 h-1 bg-gold rounded-full" />
                )}
              </div>
              <span className={`text-xs ${isActive ? "font-medium" : ""}`}>
                {item.label}
              </span>
            </button>
          );
        })}
      </div>
    </div>
  );
}

import { ChevronLeft, Plus, Star, Trash2, Edit } from "lucide-react";
import { useState } from "react";

interface FavoriteVersesScreenProps {
  onBack: () => void;
}

export default function FavoriteVersesScreen({ onBack }: FavoriteVersesScreenProps) {
  const [showAddVerse, setShowAddVerse] = useState(false);
  const [verseText, setVerseText] = useState("");
  const [verseReference, setVerseReference] = useState("");
  const [editingId, setEditingId] = useState<number | null>(null);

  const [verses, setVerses] = useState([
    {
      id: 1,
      text: "The Lord is my strength and my shield; my heart trusts in him, and he helps me.",
      reference: "Psalm 28:7",
      isDefault: true,
    },
    {
      id: 2,
      text: "For I know the plans I have for you, declares the Lord, plans to prosper you and not to harm you, plans to give you hope and a future.",
      reference: "Jeremiah 29:11",
      isDefault: false,
    },
    {
      id: 3,
      text: "Trust in the Lord with all your heart and lean not on your own understanding.",
      reference: "Proverbs 3:5",
      isDefault: false,
    },
  ]);

  const handleSetDefault = (id: number) => {
    setVerses(verses.map(v => ({ ...v, isDefault: v.id === id })));
  };

  const handleDelete = (id: number) => {
    setVerses(verses.filter(v => v.id !== id));
  };

  return (
    <div className="h-screen w-full bg-background overflow-y-auto pb-20">
      {/* Header */}
      <div className="bg-gradient-to-br from-navy to-[#0f1419] text-ivory p-6 pb-8">
        <div className="flex items-center justify-between mb-2">
          <div className="flex items-center gap-4">
            <button onClick={onBack} className="p-2 hover:bg-white/10 rounded-xl transition-colors">
              <ChevronLeft className="w-6 h-6" />
            </button>
            <h1 className="text-2xl">Favorite Verses</h1>
          </div>
          <button
            onClick={() => setShowAddVerse(true)}
            className="bg-gradient-to-br from-gold to-sunset p-2.5 rounded-full hover:shadow-lg transition-all active:scale-95"
          >
            <Plus className="w-5 h-5" />
          </button>
        </div>
        <p className="text-beige/70 text-sm ml-14">Manage your daily encouragement verses</p>
      </div>

      <div className="p-6 space-y-6">
        {/* Info card */}
        <div className="bg-gradient-to-br from-gold/10 to-sunset/10 rounded-2xl p-4 border border-gold/20">
          <div className="flex items-start gap-3">
            <Star className="w-5 h-5 text-gold flex-shrink-0 mt-0.5" />
            <div>
              <p className="text-sm text-navy">
                Your default verse will appear on the home screen as daily encouragement.
              </p>
            </div>
          </div>
        </div>

        {/* Add verse form */}
        {showAddVerse && (
          <div className="bg-card border-2 border-gold/30 rounded-2xl p-5 space-y-4 shadow-lg">
            <h3 className="text-navy">Add New Verse</h3>

            <div className="space-y-3">
              <textarea
                value={verseText}
                onChange={(e) => setVerseText(e.target.value)}
                placeholder="Enter the verse text..."
                className="w-full bg-input-background rounded-xl p-4 text-sm focus:outline-none focus:ring-2 focus:ring-gold/50 min-h-[100px] resize-none"
              />

              <input
                type="text"
                value={verseReference}
                onChange={(e) => setVerseReference(e.target.value)}
                placeholder="Reference (e.g., John 3:16)"
                className="w-full bg-input-background rounded-xl p-3 text-sm focus:outline-none focus:ring-2 focus:ring-gold/50"
              />
            </div>

            <div className="flex gap-2">
              <button
                onClick={() => {
                  setVerseText("");
                  setVerseReference("");
                  setShowAddVerse(false);
                }}
                className="flex-1 bg-muted text-muted-foreground rounded-xl p-3 hover:bg-muted/80 transition-all"
              >
                Cancel
              </button>
              <button
                onClick={() => {
                  if (verseText && verseReference) {
                    setVerses([...verses, {
                      id: Date.now(),
                      text: verseText,
                      reference: verseReference,
                      isDefault: verses.length === 0
                    }]);
                    setVerseText("");
                    setVerseReference("");
                    setShowAddVerse(false);
                  }
                }}
                className="flex-1 bg-gradient-to-br from-gold to-sunset text-ivory rounded-xl p-3 hover:shadow-lg transition-all active:scale-98"
              >
                Add Verse
              </button>
            </div>
          </div>
        )}

        {/* Verses list */}
        <div className="space-y-3">
          {verses.map((verse) => (
            <div
              key={verse.id}
              className={`bg-card border rounded-2xl p-5 shadow-sm ${
                verse.isDefault ? "border-gold/50 bg-gradient-to-br from-gold/5 to-transparent" : "border-border"
              }`}
            >
              <div className="flex items-start justify-between gap-3 mb-3">
                <div className="flex-1">
                  {verse.isDefault && (
                    <div className="flex items-center gap-1 mb-2">
                      <Star className="w-4 h-4 text-gold fill-gold" />
                      <span className="text-xs text-gold">Default Verse</span>
                    </div>
                  )}
                  <p className="text-sm text-navy leading-relaxed italic mb-2">
                    "{verse.text}"
                  </p>
                  <p className="text-xs text-gold">{verse.reference}</p>
                </div>
              </div>

              <div className="flex gap-2 pt-3 border-t border-border">
                {!verse.isDefault && (
                  <button
                    onClick={() => handleSetDefault(verse.id)}
                    className="flex-1 bg-gold/10 text-gold rounded-xl px-3 py-2 text-sm hover:bg-gold/20 transition-all flex items-center justify-center gap-1"
                  >
                    <Star className="w-3.5 h-3.5" />
                    Set as Default
                  </button>
                )}
                <button
                  onClick={() => setEditingId(verse.id)}
                  className="flex-1 bg-muted text-muted-foreground rounded-xl px-3 py-2 text-sm hover:bg-muted/80 transition-all flex items-center justify-center gap-1"
                >
                  <Edit className="w-3.5 h-3.5" />
                  Edit
                </button>
                <button
                  onClick={() => handleDelete(verse.id)}
                  className="flex-1 bg-destructive/10 text-destructive rounded-xl px-3 py-2 text-sm hover:bg-destructive/20 transition-all flex items-center justify-center gap-1"
                >
                  <Trash2 className="w-3.5 h-3.5" />
                  Delete
                </button>
              </div>
            </div>
          ))}
        </div>

        {verses.length === 0 && (
          <div className="text-center py-12">
            <Star className="w-12 h-12 text-muted-foreground mx-auto mb-3" />
            <p className="text-muted-foreground">No favorite verses yet</p>
            <p className="text-sm text-muted-foreground mt-1">
              Add your first verse to see it on the home screen
            </p>
          </div>
        )}
      </div>
    </div>
  );
}

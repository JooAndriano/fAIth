import { X, Edit, Trash2, CheckCircle2, Clock } from "lucide-react";
import { motion } from "motion/react";

interface PrayerBottomSheetProps {
  prayer: {
    id: number;
    title: string;
    date: string;
    category: string;
    answered: boolean;
  };
  onClose: () => void;
  onEdit: () => void;
  onDelete: () => void;
  onToggleStatus: () => void;
}

export default function PrayerBottomSheet({ prayer, onClose, onEdit, onDelete, onToggleStatus }: PrayerBottomSheetProps) {
  return (
    <div className="fixed inset-0 z-50 flex items-end">
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        onClick={onClose}
        className="absolute inset-0 bg-black/50"
      />

      <motion.div
        initial={{ y: "100%" }}
        animate={{ y: 0 }}
        exit={{ y: "100%" }}
        transition={{ type: "spring", damping: 30, stiffness: 300 }}
        className="relative w-full max-w-md mx-auto bg-card rounded-t-3xl shadow-2xl"
      >
        <div className="p-6 space-y-4">
          {/* Handle */}
          <div className="w-12 h-1 bg-muted rounded-full mx-auto" />

          {/* Header */}
          <div className="flex items-start justify-between">
            <div>
              <h3 className="text-navy">{prayer.title}</h3>
              <p className="text-xs text-muted-foreground mt-1">{prayer.date}</p>
            </div>
            <button
              onClick={onClose}
              className="p-2 hover:bg-muted rounded-xl transition-colors"
            >
              <X className="w-5 h-5 text-muted-foreground" />
            </button>
          </div>

          {/* Actions */}
          <div className="space-y-2">
            <button
              onClick={onEdit}
              className="w-full bg-muted/50 hover:bg-muted rounded-2xl p-4 flex items-center gap-3 transition-colors"
            >
              <div className="bg-gold/20 p-2 rounded-xl">
                <Edit className="w-5 h-5 text-gold" />
              </div>
              <span className="text-navy">Edit Prayer</span>
            </button>

            <button
              onClick={onToggleStatus}
              className="w-full bg-muted/50 hover:bg-muted rounded-2xl p-4 flex items-center gap-3 transition-colors"
            >
              <div className={`${prayer.answered ? 'bg-sunset/20' : 'bg-gold/20'} p-2 rounded-xl`}>
                {prayer.answered ? (
                  <Clock className="w-5 h-5 text-sunset" />
                ) : (
                  <CheckCircle2 className="w-5 h-5 text-gold" />
                )}
              </div>
              <span className="text-navy">
                Mark as {prayer.answered ? "Active" : "Answered"}
              </span>
            </button>

            <button
              onClick={onDelete}
              className="w-full bg-destructive/10 hover:bg-destructive/20 rounded-2xl p-4 flex items-center gap-3 transition-colors"
            >
              <div className="bg-destructive/20 p-2 rounded-xl">
                <Trash2 className="w-5 h-5 text-destructive" />
              </div>
              <span className="text-destructive">Delete Prayer</span>
            </button>
          </div>
        </div>
      </motion.div>
    </div>
  );
}

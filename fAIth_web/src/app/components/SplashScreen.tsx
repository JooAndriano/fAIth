import { motion } from "motion/react";
import faithIcon from "../../imports/faith-icon.png";

export default function SplashScreen() {
  return (
    <div className="h-screen w-full bg-gradient-to-b from-navy via-navy to-[#0f1419] flex items-center justify-center overflow-hidden relative">
      {/* Background subtle pattern */}
      <div className="absolute inset-0 opacity-5">
        <div className="absolute top-20 left-10 w-64 h-64 bg-gold rounded-full blur-3xl" />
        <div className="absolute bottom-20 right-10 w-80 h-80 bg-sunset rounded-full blur-3xl" />
      </div>

      {/* Logo and branding */}
      <div className="flex flex-col items-center gap-8 z-10">
        <motion.div
          initial={{ scale: 0, rotate: -180 }}
          animate={{ scale: 1, rotate: 0 }}
          transition={{ duration: 0.8, ease: "easeOut" }}
          className="relative"
        >
          {/* Glowing effect */}
          <div className="absolute inset-0 bg-gold/30 blur-2xl rounded-full scale-150" />

          {/* App icon */}
          <div className="relative">
            <img src={faithIcon} alt="fAIth" className="w-32 h-32 rounded-3xl shadow-2xl" />
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4, duration: 0.6 }}
          className="text-center space-y-2"
        >
          <h1 className="text-5xl text-ivory tracking-wider">
            f<span className="text-gold">AI</span>th
          </h1>
          <p className="text-beige/70 text-sm tracking-wide">Your AI Spiritual Companion</p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.8, duration: 0.6 }}
          className="flex gap-2 mt-4"
        >
          <div className="w-2 h-2 bg-gold rounded-full animate-pulse" />
          <div className="w-2 h-2 bg-gold rounded-full animate-pulse delay-100" style={{ animationDelay: "0.1s" }} />
          <div className="w-2 h-2 bg-gold rounded-full animate-pulse delay-200" style={{ animationDelay: "0.2s" }} />
        </motion.div>
      </div>
    </div>
  );
}

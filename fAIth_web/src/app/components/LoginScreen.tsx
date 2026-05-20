import { motion } from "motion/react";
import { Sparkles } from "lucide-react";
import faithIcon from "../../imports/faith-icon.png";

interface LoginScreenProps {
  onLogin: () => void;
}

export default function LoginScreen({ onLogin }: LoginScreenProps) {
  return (
    <div className="h-screen w-full bg-gradient-to-b from-ivory via-background to-beige/30 flex flex-col items-center justify-between p-6 overflow-hidden relative">
      {/* Background decoration */}
      <div className="absolute inset-0 opacity-10">
        <div className="absolute top-32 right-0 w-96 h-96 bg-sunset rounded-full blur-3xl" />
        <div className="absolute bottom-0 left-0 w-80 h-80 bg-gold rounded-full blur-3xl" />
      </div>

      <div className="flex-1 flex flex-col items-center justify-center gap-8 z-10 max-w-md w-full">
        {/* Logo */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
          className="flex items-center gap-3"
        >
          <img src={faithIcon} alt="fAIth" className="w-16 h-16 rounded-2xl shadow-lg" />
          <h1 className="text-4xl text-navy">
            f<span className="text-gold">AI</span>th
          </h1>
        </motion.div>

        {/* Welcome message */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2, duration: 0.6 }}
          className="text-center space-y-3"
        >
          <h2 className="text-2xl text-navy">Welcome Home</h2>
          <p className="text-muted-foreground leading-relaxed">
            Begin your journey of faith with AI-powered spiritual guidance, daily devotionals, and prayer support.
          </p>
        </motion.div>

        {/* Illustration placeholder - peaceful dove or praying hands */}
        <motion.div
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.4, duration: 0.6 }}
          className="w-64 h-48 bg-gradient-to-br from-gold/10 to-sunset/10 rounded-3xl flex items-center justify-center relative overflow-hidden"
        >
          <div className="absolute inset-0 bg-gradient-to-br from-gold/5 via-transparent to-sunset/5" />
          <Sparkles className="w-16 h-16 text-gold/40" />
        </motion.div>

        {/* Sign in button */}
        <motion.button
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.6, duration: 0.6 }}
          onClick={onLogin}
          className="w-full bg-white border-2 border-border rounded-2xl p-4 flex items-center justify-center gap-3 shadow-lg hover:shadow-xl transition-all active:scale-98"
        >
          <div className="w-6 h-6 bg-gradient-to-br from-[#4285F4] via-[#34A853] to-[#FBBC05] rounded-full" />
          <span className="text-navy">Continue with Google</span>
        </motion.button>
      </div>

      {/* Footer */}
      <motion.p
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.8, duration: 0.6 }}
        className="text-muted-foreground text-xs text-center z-10"
      >
        By continuing, you agree to our Terms of Service and Privacy Policy
      </motion.p>
    </div>
  );
}

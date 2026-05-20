import { useState, useEffect } from "react";
import SplashScreen from "./components/SplashScreen";
import LoginScreen from "./components/LoginScreen";
import HomeScreen from "./components/HomeScreen";
import AIChatScreen from "./components/AIChatScreen";
import DevotionalScreen from "./components/DevotionalScreen";
import BibleStudyScreen from "./components/BibleStudyScreen";
import BibleReadingScreen from "./components/BibleReadingScreen";
import PrayerJournalScreen from "./components/PrayerJournalScreen";
import AllPrayersScreen from "./components/AllPrayersScreen";
import NearbyChurchesScreen from "./components/NearbyChurchesScreen";
import SettingsScreen from "./components/SettingsScreen";
import ProfileSettingsScreen from "./components/ProfileSettingsScreen";
import SavedDevotionalsScreen from "./components/SavedDevotionalsScreen";
import FavoriteVersesScreen from "./components/FavoriteVersesScreen";
import BottomNavigation from "./components/BottomNavigation";
import AdditionalSettingsScreen from "./components/AdditionalSettingsScreen";

type ScreenType = "splash" | "login" | "home" | "chat" | "devotional" | "bible" | "bible-reading" | "prayer" | "all-prayers" | "churches" | "settings" | "profile-settings" | "saved-devotionals" | "favorite-verses" | "additional-settings";

export default function App() {
  const [currentScreen, setCurrentScreen] = useState<ScreenType>("splash");
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [selectedPrayer, setSelectedPrayer] = useState<any>(null);

  useEffect(() => {
    if (currentScreen === "splash") {
      const timer = setTimeout(() => {
        setCurrentScreen("login");
      }, 2500);
      return () => clearTimeout(timer);
    }
  }, [currentScreen]);

  const handleLogin = () => {
    setIsAuthenticated(true);
    setCurrentScreen("home");
  };

  const handleNavigate = (screen: ScreenType) => {
    setCurrentScreen(screen);
  };

  const handleBack = () => {
    setCurrentScreen("home");
  };

  return (
    <div className="size-full bg-background overflow-hidden">
      {/* Mobile container - centered for desktop preview */}
      <div className="h-full max-w-md mx-auto relative bg-background shadow-2xl">
        {currentScreen === "splash" && <SplashScreen />}
        {currentScreen === "login" && <LoginScreen onLogin={handleLogin} />}
        {currentScreen === "home" && <HomeScreen onNavigate={handleNavigate} />}
        {currentScreen === "chat" && <AIChatScreen />}
        {currentScreen === "devotional" && <DevotionalScreen onBack={handleBack} />}
        {currentScreen === "bible" && <BibleStudyScreen onNavigate={handleNavigate} />}
        {currentScreen === "bible-reading" && <BibleReadingScreen onBack={handleBack} />}
        {currentScreen === "prayer" && <PrayerJournalScreen onNavigate={handleNavigate} />}
        {currentScreen === "additional-settings" && <AdditionalSettingsScreen onNavigate={handleNavigate} />}
        {currentScreen === "all-prayers" && (
          <AllPrayersScreen
            onBack={handleBack}
            onPrayerClick={(prayer) => setSelectedPrayer(prayer)}
          />
        )}
        {currentScreen === "churches" && <NearbyChurchesScreen />}
        {currentScreen === "settings" && <SettingsScreen onNavigate={handleNavigate} />}
        {currentScreen === "profile-settings" && (
          <ProfileSettingsScreen onBack={handleBack} onNavigate={handleNavigate} />
        )}
        {currentScreen === "saved-devotionals" && (
          <SavedDevotionalsScreen
            onBack={handleBack}
            onDevotionalClick={() => handleNavigate("devotional")}
          />
        )}
        {currentScreen === "favorite-verses" && <FavoriteVersesScreen onBack={handleBack} />}

        {/* Bottom Navigation - only show after login and on main screens */}
        {isAuthenticated && ["home", "chat", "bible", "prayer", "churches", "settings"].includes(currentScreen) && (
          <BottomNavigation activeScreen={currentScreen} onNavigate={handleNavigate} />
        )}
      </div>
    </div>
  );
}
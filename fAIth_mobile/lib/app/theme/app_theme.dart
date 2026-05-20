import 'package:flutter/material.dart';

class AppTheme {
  // Color tokens
  static const Color primaryGold = Color(0xFFD4A574);
  static const Color sunsetAccent = Color(0xFFC97B63);
  static const Color navy = Color(0xFF111827);
  static const Color background = Color(0xFFF8F6F2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF9CA3AF);
  static const Color darkGrey = Color(0xFF4B5563);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryGold,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.light(
        primary: primaryGold,
        secondary: sunsetAccent,
        surface: white,
        background: background,
        error: Colors.red,
        onPrimary: white,
        onSecondary: white,
        onSurface: navy,
        onBackground: navy,
        onError: white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: navy,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: primaryGold,
        unselectedItemColor: grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: navy,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: navy,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: navy,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: navy,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: navy,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: navy,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: navy,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: navy,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: grey,
        ),
      ),
      cardTheme: CardThemeData(
        color: white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGold,
          foregroundColor: white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryGold, width: 2),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryGold,
      scaffoldBackgroundColor: navy,
      colorScheme: const ColorScheme.dark(
        primary: primaryGold,
        secondary: sunsetAccent,
        surface: Color(0xFF1F2937),
        background: navy,
        error: Colors.red,
        onPrimary: navy,
        onSecondary: white,
        onSurface: white,
        onBackground: white,
        onError: white,
      ),
    );
  }
}

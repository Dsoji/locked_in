import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white, // Light background
      primaryColor: Colors.black,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.black,
        brightness: Brightness.light,
        primary: Colors.black, // Primary accent is now black
        onPrimary: Colors.white,
        secondary: const Color(0xFFE0E0E0), // Light grey
        onSecondary: Colors.black,
        surface: Colors.white, // Light surface
        onSurface: Colors.black,
        error: const Color(0xFFB00020),
        onError: Colors.white,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black, // Black text
          fontSize: 22,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
        iconTheme: IconThemeData(color: Colors.black, size: 28), // Black icons
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 32,
        ),
        headlineMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 24,
        ),
        titleLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        bodyLarge: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: Colors.black54,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.1,
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFFF5F5F5), // Light grey card background
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.black.withOpacity(0.05)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Black button
          foregroundColor: Colors.white, // White text
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
          elevation: 0,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white, // White nav bar
        indicatorColor: Colors.black, // Black indicator
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            );
          }
          return const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: Colors.white, size: 24);
          }
          return const IconThemeData(color: Colors.grey, size: 24);
        }),
      ),
    );
  }
}

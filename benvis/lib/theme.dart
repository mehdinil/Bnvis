import 'package:flutter/material.dart';

/// تم اصلی Benvis با پالت رنگی dark و glassmorphism
class BenvisTheme {
  // رنگ‌های اصلی Benvis
  static const purple = Color(0xFF7C3AED);
  static const blue = Color(0xFF38BDF8);
  static const bg = Color(0xFF0B0F25);
  static const cardGlass = Color(0x1AFFFFFF); // 10% white

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: purple,
          secondary: blue,
          surface: cardGlass,
          background: bg,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF1A1F3A),
          indicatorColor: purple.withOpacity(0.3),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        cardTheme: CardThemeData(
          color: cardGlass,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      );
}


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryGradient = LinearGradient(
    colors: [
      Color(0xFFFF4B6B),
      Color(0xFF891BDB),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const cardGradient = LinearGradient(
    colors: [
      Color(0xFFFF4B6B),
      Color(0xFF891BDB),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final darkTheme = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFFF4B6B),
    scaffoldBackgroundColor: Colors.black,
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: const Color(0xFFFF4B6B),
      secondary: const Color(0xFF891BDB),
    ),
  );

  static final lightTheme = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFF4B6B),
    scaffoldBackgroundColor: Colors.white,
    cardColor: const Color(0xFFF5F5F5),
    dialogBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Color(0xFF2C2C2C)),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.light().textTheme,
    ).copyWith(
      headlineMedium: const TextStyle(color: Color(0xFF2C2C2C)),
      titleLarge: const TextStyle(color: Color(0xFF2C2C2C)),
      titleMedium: const TextStyle(color: Color(0xFF2C2C2C)),
      bodyLarge: const TextStyle(color: Color(0xFF2C2C2C)),
      labelLarge: const TextStyle(color: Color(0xFF2C2C2C)),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xFFFF4B6B),
      secondary: const Color(0xFF891BDB),
      surface: Colors.white,
      onSurface: const Color(0xFF2C2C2C),
    ),
  );

  static const cardDecoration = BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );

  static const bottomNavBarDecoration = BoxDecoration(
    color: Color(0xFF1A1A1A),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );
}

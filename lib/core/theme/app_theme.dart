import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF990000),
      scaffoldBackgroundColor: Colors.grey[200],
      fontFamily: 'Montserrat Regular',
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Color(0xFF990000),
        elevation: 4,
        titleTextStyle: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFF990000),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
        elevation: 2,
      ),
      iconTheme: const IconThemeData(color: Colors.black54),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.black87),
        headlineSmall:
            TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: const Color(0xFF990000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black87),
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF990000),
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'Montserrat Regular',
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Color(0xFF4B0000),
        elevation: 4,
        titleTextStyle: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFF990000),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
      ),
      cardTheme: CardTheme(
        color: Colors.grey[850],
        elevation: 2,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white70),
        headlineSmall:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: const Color(0xFF990000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}

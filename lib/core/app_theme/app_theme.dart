import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: Colors.grey[200],
      fontFamily: 'Raleway',
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Raleway'),
              backgroundColor: const Color(0xFF990000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ))),
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Color(0xFF990000),
          elevation: 4,
          shadowColor: Colors.white,
          titleTextStyle: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)));
}

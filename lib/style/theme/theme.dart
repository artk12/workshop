
import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  textTheme: TextTheme(
    headline1: TextStyle(color: Colors.white.withOpacity(0.85),fontFamily: 'bold',fontSize: 20),
    headline2: TextStyle(color: Colors.white.withOpacity(0.85),fontFamily: 'regular',fontSize: 20),
    bodyText1: TextStyle(color: Colors.white.withOpacity(0.85),fontFamily: 'light',fontSize: 20),
  ),
  fontFamily: 'light',
  // inputDecorationTheme: InputDecorationTheme(
  //   enabledBorder: OutlineInputBorder(
  //     borderSide: BorderSide(
  //         color: Colors.white70, width: 1.0),
  //   ),
  //   focusedBorder: OutlineInputBorder(
  //     borderSide: BorderSide(
  //         color: Colors.white70, width: 1.0),
  //   ),
  //   border: OutlineInputBorder(
  //     borderSide: BorderSide(
  //         color: Colors.white70, width: 1.0),
  //   ),
  // ),
  dividerColor: Colors.white70,
  canvasColor: Colors.black.withOpacity(0.7),
  iconTheme: IconThemeData(color: Colors.white.withOpacity(0.85),size: 14),
  primaryColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
      MaterialStateProperty.resolveWith((states) => Colors.black),
    ),
  ),
  // outlinedButtonTheme: OutlinedButtonThemeData(
  //   style: OutlinedButton.styleFrom(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  //     side: BorderSide(
  //       width: 1,
  //       color: Colors.white.withOpacity(0.6),
  //     ),
  //   ),
  // ),
);
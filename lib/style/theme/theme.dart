import 'package:flutter/material.dart';
import 'package:workshop/style/theme/textstyle.dart';

ThemeData light = ThemeData(
  textTheme: TextTheme(
    headline1: MyTextStyle.headLine1,
    headline2: MyTextStyle.headLine2,
    headline3: MyTextStyle.headLine3,
    headline4: MyTextStyle.headLine4,
    headline5: MyTextStyle.headLine5,
    headline6: MyTextStyle.headLine6,
    bodyText1: MyTextStyle.body1,
    bodyText2: MyTextStyle.body2
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
  canvasColor: Color(0xff4d5566),
  // scaffoldBackgroundColor: Color(0xfff3f3f3),
  scaffoldBackgroundColor: Color(0xff37303d),
  iconTheme: IconThemeData(color: Colors.white.withOpacity(0.85), size: 14),
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

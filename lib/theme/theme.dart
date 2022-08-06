import 'package:flutter/material.dart';

final themeData = ThemeData(
  fontFamily: 'Montserrat',
  textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Color(0xff333333),
      ),
      bodyText2: TextStyle(
        color: Color(0xff333333),
      ),
      headline1: TextStyle(
        color: Color(0xff333333),
        fontWeight: FontWeight.w100,
        letterSpacing: 1.3,
        fontSize: 28,
      )),
  primaryColor: const Color(0xffAD5A6F),
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xffAD5A6F),
      secondary: Color(0Xff3E5266),
      onPrimary: Colors.white,
      error: Colors.black,
      onError: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white10,
      background: Colors.white,
      surface: Colors.white10,
      onSecondary: Colors.white12),
);

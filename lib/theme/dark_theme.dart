import 'package:flutter/material.dart';

final color = Colors.black;
ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: Color(0xFF70BCFF),
  secondaryHeaderColor: Color(0xFF009f67),
  disabledColor: Color(0xffa2a7ad),
  backgroundColor: Color(0xFF343636),
  errorColor: Color(0xFFdd3135),
  brightness: Brightness.dark,
  hintColor: Color(0xFFbebebe),
  cardColor: Colors.black,
  colorScheme: ColorScheme.dark(
      primary: Color(0xFF70BCFF), secondary: Color(0xFF70BCFF)),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Color(0xFF70BCFF))),
);

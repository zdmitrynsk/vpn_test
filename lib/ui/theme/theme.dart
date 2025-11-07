import 'package:flutter/material.dart';

const _primaryColor = Color(0xFF1D58E5);
const _backgroundColor = Color(0xFF1A2838);

final appTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: _primaryColor,
  primaryTextTheme: TextTheme(),
  appBarTheme: _appBarTheme,
  textTheme: _textTheme,
  scaffoldBackgroundColor: _backgroundColor,
  hintColor: Colors.white38,
  inputDecorationTheme: _inputDecorationTheme,
);

const _appBarTheme = AppBarTheme(
  backgroundColor: _backgroundColor,
);

const _textTheme = TextTheme(
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
);

const _inputDecorationTheme = InputDecorationTheme(
  fillColor: Color(0xFF2B3E58),
);

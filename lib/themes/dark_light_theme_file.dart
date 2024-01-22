import 'package:flutter/material.dart';

var lightTheme = ThemeData(
  fontFamily: 'Tajawal',
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.amber,
  ),
  cardTheme: CardTheme(
    color: const Color(0xfff5f5f5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
      .copyWith(secondary: Colors.amber, brightness: Brightness.light)
      .copyWith(background: Colors.white),
);

var darkTheme = ThemeData(
  primaryColor: const Color.fromRGBO(58, 58, 60, 100),
  scaffoldBackgroundColor: const Color.fromRGBO(58, 58, 60, 100),
  fontFamily: 'Tajawal',
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.amber,
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
      .copyWith(secondary: Colors.amber, brightness: Brightness.dark)
      .copyWith(background: const Color.fromRGBO(58, 58, 60, 100)),
);

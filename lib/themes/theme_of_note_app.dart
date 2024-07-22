import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontSize: 15.7,
      color: Colors.grey.shade400,
    ),
    titleSmall: TextStyle(
      fontSize: 17.7,
      color: Colors.grey.shade500,
    ),
  ),
  dialogTheme: const DialogTheme(
    iconColor: Colors.white
  ),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.black26,
    secondary: Colors.black,
    inversePrimary: Colors.grey.shade300,
  )
);

ThemeData lightMode = ThemeData(
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 15.7,
        color: Colors.grey.shade600,
      ),
      titleSmall: TextStyle(
        fontSize: 12.7,
        color: Colors.grey.shade600,
      ),
    ),
    dialogTheme: const DialogTheme(
        iconColor: Colors.black
    ),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Colors.grey.shade300,
        primary: Colors.grey.shade200,
        secondary: Colors.grey.shade200,
        inversePrimary: Colors.black
    )
);
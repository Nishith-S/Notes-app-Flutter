import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  dialogTheme: const DialogTheme(
    iconColor: Colors.white
  ),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.black26,
    secondary: Colors.black,
    inversePrimary: Colors.white
  )
);

ThemeData lightMode = ThemeData(
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
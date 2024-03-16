import 'package:flutter/material.dart';
import 'package:sewan/theme/colors_model.dart';

class AppColors {
  static ColorsModel light = ColorsModel(
    primary: Colors.deepPurple,
    primaryLighter: const Color(0xFFFFA870),
    primaryDarker: const Color(0xFFF54121),
    primaryTransparent: const Color(0xAAF76343),
    secondary: const Color(0xFF0010C6),
    secondaryTransparent: const Color(0xAA0010C6),
    string1: Colors.white,
    string2: const Color(0xFF3B3B3B),
    background: const Color(0xFFE5E5E5),
    white: const Color(0xFFFFFFFF),
    grey: const Color(0xFFE9EBED),
    black: const Color(0xff0F1318),
  );

  static ColorsModel dark = ColorsModel(
    primary: Colors.deepPurple,
    primaryLighter: const Color(0xFFFFA870),
    primaryDarker: const Color(0xFFF54121),
    primaryTransparent: const Color(0xAAF76343),
    secondary: const Color(0xFF0010C6),
    secondaryTransparent: const Color(0xAA0010C6),
    string1: Colors.white,
    string2: const Color(0xFF3B3B3B),
    background: const Color(0xff0F1318),
    white: const Color(0xFFFFFFFF),
    grey: const Color(0xFFE9EBED),
    black: const Color(0xFF000000),
  );
}

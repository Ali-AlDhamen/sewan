import 'package:flutter/material.dart';

class ColorsModel {
  ColorsModel({
    required this.primary,
    required this.primaryLighter,
    required this.primaryDarker,
    required this.primaryTransparent,
    required this.secondary,
    required this.secondaryTransparent,
    required this.string1,
    required this.string2,
    required this.background,
    required this.white,
    required this.grey,
    required this.black,
  });

  final Color primary;
  final Color primaryLighter;
  final Color primaryDarker;
  final Color primaryTransparent;
  final Color secondary;
  final Color secondaryTransparent;
  final Color string1;
  final Color string2;
  final Color background;
  final Color white;
  final Color grey;
  final Color black;
}

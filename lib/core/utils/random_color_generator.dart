import 'dart:math';

import 'package:flutter/material.dart';

Color randomColorGenerator() {
  final _random = new Random();
  return Color.fromARGB(
    255,
    _random.nextInt(256),
    _random.nextInt(256),
    _random.nextInt(256),
  );
}

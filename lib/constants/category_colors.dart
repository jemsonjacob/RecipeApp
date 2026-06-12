import 'dart:math';

import 'package:flutter/material.dart';

Color getCuisineColor(String cuisine) {
  final random = Random(cuisine.hashCode);

  return Color.fromARGB(
    255,
    random.nextInt(200),
    random.nextInt(200),
    random.nextInt(200),
  );
}

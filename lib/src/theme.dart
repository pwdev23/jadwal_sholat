import 'package:flutter/material.dart';

const seedColor = Color(0xff01d255);

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
  useMaterial3: true,
);

final dark = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
  useMaterial3: true,
);

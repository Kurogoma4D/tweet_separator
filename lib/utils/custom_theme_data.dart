import 'package:flutter/material.dart';

final ThemeData customThemeData = ThemeData(
  scaffoldBackgroundColor: const Color(0xff3C4758),
  cardTheme: CardTheme(
    color: const Color(0xff494F59),
    margin: const EdgeInsets.all(32),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    shadowColor: Colors.black.withOpacity(0.4),
    elevation: 12,
  ),
);

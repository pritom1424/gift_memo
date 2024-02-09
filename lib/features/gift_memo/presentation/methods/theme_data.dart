import 'package:flutter/material.dart';

class GiftMemoThemeData {
  static ThemeData getThemeData(ColorScheme kColorScheme) {
    return ThemeData().copyWith(
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      cardTheme: const CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'Amity_Jack',
              color: kColorScheme.onSecondaryContainer,
              fontSize: 18,
            ),
            labelLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 20,
            ),
            bodyLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'QuickSand-Medium',
              color: kColorScheme.onSecondaryContainer,
              fontSize: 15,
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Advent-Lt1',
              color: kColorScheme.onSecondaryContainer,
              fontSize: 12,
            ),
          ),
    );
  }
}

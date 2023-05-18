import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(1, 226, 28, 87));
var kColorDarkScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 163, 20, 63),
);

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kColorDarkScheme,
      cardTheme: CardTheme().copyWith(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: kColorDarkScheme.secondaryContainer,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorDarkScheme.primaryContainer,
          foregroundColor: kColorDarkScheme.onPrimaryContainer,
        ),
      ),
    ),
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColorScheme,
      cardTheme: CardTheme().copyWith(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: kColorScheme.secondaryContainer,
      ),
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 17,
            ),
          ),
    ),
    home: Expenses(),
  ));
}

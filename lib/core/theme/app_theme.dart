import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const _background = Color(0xFFF5F5F0);
  static const _ink = Color(0xFF202820);
  static const _accent = Color(0xFFE7A94B);

  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _ink,
        surface: _background,
        brightness: Brightness.light,
      ).copyWith(primary: _ink, secondary: _accent),
      scaffoldBackgroundColor: _background,
      appBarTheme: const AppBarTheme(
        backgroundColor: _background,
        foregroundColor: _ink,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          side: BorderSide(color: Color(0xFFE4E7DF)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _ink,
          minimumSize: const Size(0, 48),
          side: const BorderSide(color: Color(0xFFB8C6B9)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      useMaterial3: true,
    );
  }
}

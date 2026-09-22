import 'package:flutter/material.dart';

/// Themes clair et sombre de l'application, derives d'une meme couleur source
/// pour que les deux modes restent coherents.
abstract final class AppTheme {
  /// Couleur source des deux palettes.
  static const Color seedColor = Colors.deepPurple;

  static final ThemeData light = _build(.light);
  static final ThemeData dark = _build(.dark);

  static ThemeData _build(Brightness brightness) {
    final ColorScheme colors = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
    return ThemeData(
      colorScheme: colors,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.inversePrimary,
        foregroundColor: colors.onSurface,
      ),
    );
  }
}

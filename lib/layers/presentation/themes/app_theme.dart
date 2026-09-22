import 'package:flutter/material.dart';

/// Theme de l'application.
abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      );
}

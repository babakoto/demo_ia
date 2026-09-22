import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import 'components/bloc_register.dart';
import 'pages/memory_game/memory_game_page.dart';
import 'themes/app_theme.dart';

/// Racine de l'application : theme, blocs et ecran d'accueil.
class MemoryApp extends StatelessWidget {
  const MemoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocRegister(
      child: MaterialApp(
        title: AppStrings.appTitle,
        theme: AppTheme.light,
        home: const MemoryGamePage(),
      ),
    );
  }
}

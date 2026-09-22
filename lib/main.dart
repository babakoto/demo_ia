import 'package:flutter/material.dart';

import 'src/memory_game/memory_game_page.dart';
import 'src/theme/app_theme.dart';
import 'src/theme/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.themeController});

  /// Controleur de theme injecte (tests). Si absent, l'application en cree un.
  final ThemeController? themeController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Vrai lorsque le controleur a ete cree ici : lui seul doit etre libere.
  late final bool _ownsController = widget.themeController == null;
  late final ThemeController _themeController =
      widget.themeController ?? ThemeController();

  @override
  void dispose() {
    if (_ownsController) {
      _themeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      controller: _themeController,
      // `MaterialApp` n'est pas un dependant du scope : c'est ce builder qui le
      // reconstruit pour appliquer le nouveau `themeMode`.
      child: ListenableBuilder(
        listenable: _themeController,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: 'Jeu de memoire',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: _themeController.mode,
            home: child,
          );
        },
        child: const MemoryGamePage(),
      ),
    );
  }
}

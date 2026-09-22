import 'package:flutter/material.dart';

import 'theme_controller.dart';

/// Bouton de bascule clair / sombre.
///
/// L'etat affiche est deduit du theme reellement applique
/// (`Theme.of(context).brightness`) : le bouton reste juste meme quand le
/// controleur suit encore le systeme.
class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({super.key});

  static const ValueKey<String> buttonKey = ValueKey<String>('theme-mode-button');

  @override
  Widget build(BuildContext context) {
    final ThemeController? controller = ThemeScope.maybeOf(context);
    // Page montee hors de l'application (tests isoles) : rien a basculer.
    if (controller == null) return const SizedBox.shrink();

    final bool isDark = Theme.of(context).brightness == .dark;
    return IconButton(
      key: buttonKey,
      tooltip: isDark ? 'Passer en mode clair' : 'Passer en mode sombre',
      onPressed: () => controller.setDark(!isDark),
      icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
    );
  }
}

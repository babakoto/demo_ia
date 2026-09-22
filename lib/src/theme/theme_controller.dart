import 'package:flutter/material.dart';

/// Mode d'affichage choisi par l'utilisateur.
///
/// Par defaut l'application suit le reglage du systeme ([ThemeMode.system]) :
/// un telephone en mode sombre demarre directement en sombre. Des que
/// l'utilisateur utilise le bouton, son choix prend le pas sur le systeme.
///
/// Le choix n'est pas persiste : aucune dependance de stockage n'est necessaire
/// pour le comportement demande.
class ThemeController extends ChangeNotifier {
  ThemeController({ThemeMode initialMode = .system}) : _mode = initialMode;

  ThemeMode _mode;

  /// Mode applique par `MaterialApp`.
  ThemeMode get mode => _mode;

  /// Change le mode et notifie l'UI. Un mode identique ne declenche rien.
  void setMode(ThemeMode mode) {
    if (mode == _mode) return;
    _mode = mode;
    notifyListeners();
  }

  /// Force le mode sombre ou clair, en quittant le suivi du systeme.
  void setDark(bool isDark) => setMode(isDark ? .dark : .light);
}

/// Expose le [ThemeController] au sous-arbre.
///
/// `InheritedNotifier` reconstruit les widgets qui en dependent (le bouton de
/// bascule) a chaque changement de mode, sans passer le controleur de main en
/// main dans la page.
class ThemeScope extends InheritedNotifier<ThemeController> {
  const ThemeScope({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  /// Controleur le plus proche, ou `null` si la page est montee hors de
  /// l'application (tests de widgets isoles).
  static ThemeController? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeScope>()?.notifier;

  static ThemeController of(BuildContext context) {
    final ThemeController? controller = maybeOf(context);
    assert(controller != null, 'Aucun ThemeScope au-dessus de ce widget');
    return controller!;
  }
}

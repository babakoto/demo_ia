import 'package:flutter/widgets.dart';

/// Langue choisie explicitement par le joueur.
///
/// La valeur `null` signifie "suivre la langue du systeme" : `MaterialApp`
/// resout alors la locale a partir de `AppLocalizations.supportedLocales`.
class LocaleController extends ValueNotifier<Locale?> {
  LocaleController([super.value]);

  /// Selectionne [locale], ou revient a la langue du systeme si `null`.
  void select(Locale? locale) => value = locale;
}

/// Expose le [LocaleController] de l'application a ses descendants.
///
/// Les widgets qui en dependent sont reconstruits a chaque changement de
/// langue, sans avoir a faire descendre le controleur de constructeur en
/// constructeur.
class LocaleScope extends InheritedNotifier<LocaleController> {
  const LocaleScope({
    super.key,
    required LocaleController controller,
    required super.child,
  }) : super(notifier: controller);

  /// Le controleur le plus proche, ou `null` hors de l'application (par
  /// exemple lorsqu'un test pompe une page isolee).
  static LocaleController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LocaleScope>()
        ?.notifier;
  }

  /// Le controleur le plus proche. Echoue si aucun [LocaleScope] n'est present.
  static LocaleController of(BuildContext context) {
    final LocaleController? controller = maybeOf(context);
    assert(controller != null, 'Aucun LocaleScope au-dessus de ce widget.');
    return controller!;
  }
}

import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'locale_controller.dart';

/// Selecteur de langue de la barre superieure.
///
/// Il n'apparait que sous un [LocaleScope] : une page pompee isolement (tests)
/// reste affichable sans controleur de langue.
class LanguageMenu extends StatelessWidget {
  const LanguageMenu({super.key});

  static const ValueKey<String> menuKey = ValueKey<String>('language-menu');

  /// Cle de l'entree de menu correspondant a [locale].
  static ValueKey<String> optionKey(Locale locale) =>
      ValueKey<String>('language-option-${locale.languageCode}');

  /// Nom de la langue ecrit dans cette langue : un joueur qui ne lit pas la
  /// langue courante retrouve quand meme la sienne dans la liste.
  static String displayName(Locale locale) {
    return switch (locale.languageCode) {
      'fr' => 'Français',
      'en' => 'English',
      'zh' => '中文',
      _ => locale.languageCode.toUpperCase(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final LocaleController? controller = LocaleScope.maybeOf(context);
    if (controller == null) return const SizedBox.shrink();

    final AppLocalizations l10n = AppLocalizations.of(context);
    // La locale effective : elle vaut celle du systeme tant que le joueur n'a
    // rien choisi, la coche doit donc la suivre et non le controleur.
    final Locale current = Localizations.localeOf(context);

    return PopupMenuButton<Locale>(
      key: LanguageMenu.menuKey,
      tooltip: l10n.languageTooltip,
      icon: const Icon(Icons.translate),
      onSelected: controller.select,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
        for (final Locale locale in AppLocalizations.supportedLocales)
          CheckedPopupMenuItem<Locale>(
            key: LanguageMenu.optionKey(locale),
            value: locale,
            checked: locale.languageCode == current.languageCode,
            child: Text(LanguageMenu.displayName(locale)),
          ),
      ],
    );
  }
}

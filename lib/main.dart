import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';
import 'src/localization/locale_controller.dart';
import 'src/memory_game/memory_game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.localeController});

  /// Controleur de langue injecte (tests). Si absent, l'app en cree un qui
  /// demarre sur la langue du systeme.
  final LocaleController? localeController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Vrai lorsque le controleur a ete cree ici : lui seul doit etre libere.
  late bool _ownsController;
  late LocaleController _localeController;

  @override
  void initState() {
    super.initState();
    _adoptController();
  }

  @override
  void didUpdateWidget(covariant MyApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.localeController != oldWidget.localeController) {
      _releaseController();
      _adoptController();
    }
  }

  void _adoptController() {
    _ownsController = widget.localeController == null;
    _localeController = widget.localeController ?? LocaleController();
  }

  void _releaseController() {
    if (_ownsController) {
      _localeController.dispose();
    }
  }

  @override
  void dispose() {
    _releaseController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LocaleScope(
      controller: _localeController,
      child: Builder(
        // Ce Builder depend du LocaleScope : il reconstruit le MaterialApp
        // avec la nouvelle locale des que le joueur change de langue.
        builder: (BuildContext context) {
          return MaterialApp(
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context).appTitle,
            locale: LocaleScope.of(context).value,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(
              colorScheme: .fromSeed(seedColor: Colors.deepPurple),
            ),
            home: const MemoryGamePage(),
          );
        },
      ),
    );
  }
}

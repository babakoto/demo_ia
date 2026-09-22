// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Jeu de memoire';

  @override
  String get restartTooltip => 'Rejouer';

  @override
  String get movesLabel => 'Coups';

  @override
  String get pairsLabel => 'Paires';

  @override
  String levelLabel(int number) {
    return 'Niveau $number';
  }

  @override
  String get victoryTitle => 'Bravo !';

  @override
  String victoryMessage(String level, int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: '$moves coups',
      one: '1 coup',
    );
    return '$level termine en $_temp0';
  }

  @override
  String get victoryReplayLabel => 'Rejouer';

  @override
  String get hiddenCardLabel => 'Carte cachee';

  @override
  String revealedCardLabel(String symbol) {
    return 'Carte $symbol';
  }

  @override
  String get languageTooltip => 'Changer de langue';
}

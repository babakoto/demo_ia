// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Memory game';

  @override
  String get restartTooltip => 'Restart';

  @override
  String get movesLabel => 'Moves';

  @override
  String get pairsLabel => 'Pairs';

  @override
  String levelLabel(int number) {
    return 'Level $number';
  }

  @override
  String get victoryTitle => 'Well done!';

  @override
  String victoryMessage(String level, int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: '$moves moves',
      one: '1 move',
    );
    return '$level completed in $_temp0';
  }

  @override
  String get victoryReplayLabel => 'Play again';

  @override
  String get hiddenCardLabel => 'Hidden card';

  @override
  String revealedCardLabel(String symbol) {
    return 'Card $symbol';
  }

  @override
  String get languageTooltip => 'Change language';
}

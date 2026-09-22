// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '记忆游戏';

  @override
  String get restartTooltip => '重新开始';

  @override
  String get movesLabel => '步数';

  @override
  String get pairsLabel => '配对';

  @override
  String levelLabel(int number) {
    return '第 $number 关';
  }

  @override
  String get victoryTitle => '太棒了！';

  @override
  String victoryMessage(String level, int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: '$moves 步',
    );
    return '$level 完成，共 $_temp0';
  }

  @override
  String get victoryReplayLabel => '再玩一次';

  @override
  String get hiddenCardLabel => '背面朝上的卡片';

  @override
  String revealedCardLabel(String symbol) {
    return '卡片 $symbol';
  }

  @override
  String get languageTooltip => '切换语言';
}

import 'package:flutter/widgets.dart';

/// Cles de widgets du jeu, partagees avec les tests.
abstract final class MemoryGameKeys {
  /// Cle de la carte affichee a la position [index] de la grille.
  static ValueKey<String> card(int index) =>
      ValueKey<String>('memory-card-$index');

  static const ValueKey<String> restartButton = ValueKey<String>('restart-button');
  static const ValueKey<String> victoryPanel = ValueKey<String>('victory-panel');
  static const ValueKey<String> victoryReplayButton =
      ValueKey<String>('victory-replay-button');
  static const ValueKey<String> movesStat = ValueKey<String>('stat-moves');
  static const ValueKey<String> pairsStat = ValueKey<String>('stat-pairs');
  static const ValueKey<String> boardLoader = ValueKey<String>('board-loader');
  static const ValueKey<String> boardError = ValueKey<String>('board-error');
}

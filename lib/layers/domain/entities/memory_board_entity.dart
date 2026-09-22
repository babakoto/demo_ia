import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'memory_card_entity.dart';
import 'memory_level_entity.dart';

part 'memory_board_entity.freezed.dart';

/// Le plateau et les regles du jeu de memoire.
///
/// Toutes les transitions sont pures : elles renvoient un nouveau plateau et ne
/// dependent ni du temps, ni de Flutter. Le bloc se contente de les enchainer.
@freezed
abstract class MemoryBoardEntity with _$MemoryBoardEntity {
  const MemoryBoardEntity._();

  const factory MemoryBoardEntity({
    /// Les cartes, dans l'ordre d'affichage de la grille.
    @Default(<MemoryCardEntity>[]) List<MemoryCardEntity> cards,

    /// Nombre de coups joues (un coup == deux cartes retournees).
    @Default(0) int moves,

    /// Index de la premiere carte retournee du coup en cours.
    int? firstPick,

    /// Index de la seconde carte, renseigne uniquement sur une paire ratee.
    int? secondPick,
  }) = _MemoryBoardEntity;

  /// Distribue un plateau melange pour [level].
  factory MemoryBoardEntity.deal({
    required MemoryLevelEntity level,
    required Random random,
  }) {
    final List<MemoryCardEntity> deck = <MemoryCardEntity>[
      for (int i = 0; i < level.pairCount; i++) ...<MemoryCardEntity>[
        MemoryCardEntity(id: i * 2, symbol: level.symbols[i]),
        MemoryCardEntity(id: i * 2 + 1, symbol: level.symbols[i]),
      ],
    ]..shuffle(random);

    return MemoryBoardEntity(cards: deck);
  }

  /// Nombre de paires a trouver pour terminer le plateau.
  int get totalPairs => cards.length ~/ 2;

  /// Nombre de paires deja trouvees.
  int get matchedPairs =>
      cards.where((MemoryCardEntity card) => card.isMatched).length ~/ 2;

  /// Vrai quand toutes les paires ont ete trouvees.
  bool get isComplete => cards.isNotEmpty && matchedPairs == totalPairs;

  /// Vrai tant qu'une paire ratee est encore affichee : les taps sont ignores.
  bool get hasPendingMismatch => firstPick != null && secondPick != null;

  /// Retourne la carte situee a [index].
  ///
  /// Les taps invalides (index hors plateau, carte deja visible, partie gagnee,
  /// paire ratee encore affichee) renvoient le plateau inchange.
  MemoryBoardEntity flip(int index) {
    if (index < 0 || index >= cards.length) return this;
    if (hasPendingMismatch || isComplete) return this;
    if (cards[index].isRevealed) return this;

    final List<MemoryCardEntity> next = List<MemoryCardEntity>.of(cards);
    next[index] = next[index].copyWith(isFaceUp: true);

    final int? first = firstPick;
    if (first == null) {
      return copyWith(cards: next, firstPick: index);
    }

    if (next[first].symbol == next[index].symbol) {
      next[first] = next[first].copyWith(isMatched: true);
      next[index] = next[index].copyWith(isMatched: true);
      return copyWith(
        cards: next,
        moves: moves + 1,
        firstPick: null,
        secondPick: null,
      );
    }

    return copyWith(cards: next, moves: moves + 1, secondPick: index);
  }

  /// Recache la paire ratee encore affichee.
  MemoryBoardEntity hidePendingMismatch() {
    final int? first = firstPick;
    final int? second = secondPick;
    if (first == null || second == null) return this;

    final List<MemoryCardEntity> next = List<MemoryCardEntity>.of(cards)
      ..[first] = cards[first].copyWith(isFaceUp: false)
      ..[second] = cards[second].copyWith(isFaceUp: false);

    return copyWith(cards: next, firstPick: null, secondPick: null);
  }
}

import 'dart:math';

import 'package:demo/layers/domain/entities/memory_board_entity.dart';
import 'package:demo/layers/domain/entities/memory_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/board_helpers.dart';

void main() {
  group('MemoryBoardEntity', () {
    late MemoryBoardEntity board;

    // Graine fixe : plateau reproductible d'une execution a l'autre.
    setUp(() {
      board = MemoryBoardEntity.deal(level: testLevel, random: Random(42));
    });

    test('distribue chaque symbole exactement deux fois', () {
      expect(board.cards, hasLength(testLevel.cardCount));
      expect(board.totalPairs, testLevel.pairCount);
      for (final String symbol in testLevel.symbols) {
        expect(
          board.cards.where((MemoryCardEntity c) => c.symbol == symbol).length,
          2,
          reason: 'Le symbole $symbol doit apparaitre deux fois',
        );
      }
      expect(board.cards.map((MemoryCardEntity c) => c.id).toSet(), hasLength(12));
      expect(board.cards.every((MemoryCardEntity c) => !c.isRevealed), isTrue);
      expect(board.isComplete, isFalse);
      expect(board.moves, 0);
    });

    test('une premiere carte retournee ne compte pas un coup', () {
      final MemoryBoardEntity next = board.flip(0);

      expect(next.cards[0].isFaceUp, isTrue);
      expect(next.moves, 0);
      expect(next.firstPick, 0);
      expect(next.hasPendingMismatch, isFalse);
    });

    test('une paire identique est validee et compte un coup', () {
      final (int first, int second) = matchingPair(board);

      final MemoryBoardEntity next = board.flip(first).flip(second);

      expect(next.moves, 1);
      expect(next.matchedPairs, 1);
      expect(next.cards[first].isMatched, isTrue);
      expect(next.cards[second].isMatched, isTrue);
      expect(next.hasPendingMismatch, isFalse);
    });

    test('une paire differente laisse les deux cartes visibles', () {
      final (int first, int second) = mismatchingPair(board);

      final MemoryBoardEntity next = board.flip(first).flip(second);

      expect(next.moves, 1);
      expect(next.matchedPairs, 0);
      expect(next.cards[first].isFaceUp, isTrue);
      expect(next.cards[second].isFaceUp, isTrue);
      expect(next.hasPendingMismatch, isTrue);
    });

    test('tant que la paire ratee est affichee, aucune carte ne bouge', () {
      final (int first, int second) = mismatchingPair(board);
      final MemoryBoardEntity locked = board.flip(first).flip(second);
      final int third = List<int>.generate(locked.cards.length, (int i) => i)
          .firstWhere((int i) => i != first && i != second);

      expect(locked.flip(third), same(locked));
    });

    test('recacher la paire ratee libere le plateau', () {
      final (int first, int second) = mismatchingPair(board);
      final MemoryBoardEntity locked = board.flip(first).flip(second);

      final MemoryBoardEntity next = locked.hidePendingMismatch();

      expect(next.cards[first].isFaceUp, isFalse);
      expect(next.cards[second].isFaceUp, isFalse);
      expect(next.hasPendingMismatch, isFalse);
      // Un coup reste un coup : le compteur ne revient pas en arriere.
      expect(next.moves, 1);
    });

    test('les taps invalides renvoient le plateau inchange', () {
      expect(board.flip(-1), same(board));
      expect(board.flip(board.cards.length), same(board));

      final MemoryBoardEntity flipped = board.flip(0);
      expect(flipped.flip(0), same(flipped));
      expect(flipped.moves, 0);
    });

    test('un plateau complet ignore les taps', () {
      MemoryBoardEntity complete = board;
      for (int pair = 0; pair < board.totalPairs; pair++) {
        final (int first, int second) = matchingPair(complete);
        complete = complete.flip(first).flip(second);
      }

      expect(complete.isComplete, isTrue);
      expect(complete.matchedPairs, testLevel.pairCount);
      expect(complete.flip(0), same(complete));
    });

    test('un plateau vide n est pas un plateau gagne', () {
      expect(const MemoryBoardEntity().isComplete, isFalse);
    });
  });

  group('MemoryLevelEntity', () {
    test('deduit la grille du nombre de symboles', () {
      expect(testLevel.pairCount, 6);
      expect(testLevel.cardCount, 12);
      expect(testLevel.rows, 4);
    });
  });
}

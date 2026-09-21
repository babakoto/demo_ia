import 'dart:math';

import 'package:demo/main.dart';
import 'package:demo/src/memory_game/memory_card.dart';
import 'package:demo/src/memory_game/memory_card_tile.dart';
import 'package:demo/src/memory_game/memory_game_controller.dart';
import 'package:demo/src/memory_game/memory_game_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MemoryGameController', () {
    late MemoryGameController controller;

    setUp(() {
      controller = MemoryGameController(
        mismatchDelay: const Duration(milliseconds: 500),
        random: Random(42),
      );
    });

    tearDown(() => controller.dispose());

    test('distribue chaque symbole exactement deux fois', () {
      final List<MemoryCard> cards = controller.cards;

      expect(cards, hasLength(12));
      expect(controller.totalPairs, 6);
      for (final String symbol in controller.level.symbols) {
        expect(
          cards.where((MemoryCard card) => card.symbol == symbol).length,
          2,
          reason: 'Le symbole $symbol doit apparaitre deux fois',
        );
      }
      expect(cards.map((MemoryCard card) => card.id).toSet(), hasLength(12));
      expect(cards.every((MemoryCard card) => !card.isRevealed), isTrue);
      expect(controller.status, MemoryGameStatus.playing);
    });

    test('une paire identique est validee et compte un coup', () {
      final List<MemoryCard> cards = controller.cards;
      const int first = 0;
      final int second = cards.indexWhere(
        (MemoryCard card) =>
            card.symbol == cards.first.symbol && card.id != cards.first.id,
      );

      controller.flipCard(first);
      expect(controller.moves, 0, reason: 'Une seule carte n est pas un coup');

      controller.flipCard(second);

      expect(controller.moves, 1);
      expect(controller.matchedPairs, 1);
      expect(controller.cards[first].isMatched, isTrue);
      expect(controller.cards[second].isMatched, isTrue);
      expect(controller.isLocked, isFalse);
    });

    test('une paire differente verrouille le plateau', () {
      final List<MemoryCard> cards = controller.cards;
      final int second = cards.indexWhere(
        (MemoryCard card) => card.symbol != cards.first.symbol,
      );

      controller.flipCard(0);
      controller.flipCard(second);

      expect(controller.moves, 1);
      expect(controller.matchedPairs, 0);
      expect(controller.isLocked, isTrue);

      // Tant que la paire ratee est affichee, aucune autre carte ne bouge.
      final int third = List<int>.generate(cards.length, (int i) => i)
          .firstWhere((int i) => i != 0 && i != second);
      controller.flipCard(third);
      expect(controller.cards[third].isFaceUp, isFalse);

      // Le timer de retournement est annule proprement par restart().
      controller.restart();
      expect(controller.isLocked, isFalse);
      expect(controller.cards.every((MemoryCard c) => !c.isRevealed), isTrue);
    });

    test('les taps invalides sont ignores', () {
      controller.flipCard(-1);
      controller.flipCard(999);
      expect(controller.cards.every((MemoryCard c) => !c.isRevealed), isTrue);

      controller.flipCard(0);
      controller.flipCard(0);
      expect(controller.moves, 0, reason: 'Retaper la meme carte ne joue pas');
    });

    test('restart redistribue et remet les compteurs a zero', () {
      final List<MemoryCard> cards = controller.cards;
      final int second = cards.indexWhere(
        (MemoryCard card) =>
            card.symbol == cards.first.symbol && card.id != cards.first.id,
      );
      controller.flipCard(0);
      controller.flipCard(second);
      expect(controller.matchedPairs, 1);

      controller.restart();

      expect(controller.moves, 0);
      expect(controller.matchedPairs, 0);
      expect(controller.status, MemoryGameStatus.playing);
      expect(controller.cards.every((MemoryCard c) => !c.isRevealed), isTrue);
    });
  });

  testWidgets('la page adopte le nouveau controleur injecte', (
    WidgetTester tester,
  ) async {
    final MemoryGameController first = MemoryGameController(random: Random(1));
    final MemoryGameController second = MemoryGameController(random: Random(2));
    addTearDown(second.dispose);

    await tester.pumpWidget(
      MaterialApp(home: MemoryGamePage(controller: first)),
    );
    await tester.pumpAndSettle();

    // Le State est reutilise (meme position, meme type) : la page doit basculer
    // sur `second`, sinon elle ecouterait un controleur libere.
    await tester.pumpWidget(
      MaterialApp(home: MemoryGamePage(controller: second)),
    );
    await tester.pumpAndSettle();

    first.dispose();
    await tester.tap(find.byKey(MemoryGamePage.cardKey(0)));
    await tester.pumpAndSettle();

    expect(second.cards[0].isFaceUp, isTrue);
    expect(find.byIcon(Icons.help_outline), findsNWidgets(11));
  });

  testWidgets('l application affiche le plateau du niveau 1', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(MemoryGamePage), findsOneWidget);
    expect(find.byType(MemoryCardTile), findsNWidgets(12));
    expect(find.text('Jeu de memoire'), findsOneWidget);
  });
}

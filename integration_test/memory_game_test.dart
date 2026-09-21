import 'dart:math';

import 'package:demo/main.dart';
import 'package:demo/src/memory_game/memory_card.dart';
import 'package:demo/src/memory_game/memory_card_tile.dart';
import 'package:demo/src/memory_game/memory_game_controller.dart';
import 'package:demo/src/memory_game/memory_game_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Contrairement au binding de `flutter test`, le binding d'integration
  // s'appuie sur l'horloge reelle : le timer de retournement court pendant que
  // le test execute ses assertions. Plutot que de parier sur un delai "assez
  // grand pour tenir", chaque test choisit la fenetre qui rend son assertion
  // deterministe.

  /// Fenetre volontairement hors d'atteinte : le verrou ne peut pas se relacher
  /// pendant qu'on verifie qu'il tient, meme sur un build debug lent.
  const Duration lockHeldDelay = Duration(minutes: 10);

  /// Fenetre courte : les tests qui attendent le relachement attendent l'etat
  /// (via [pumpUntil]) et non la duree, une frame lente ne les met pas en echec.
  const Duration lockReleasedDelay = Duration(milliseconds: 300);

  late MemoryGameController controller;

  // Graine fixe pour un plateau reproductible.
  setUp(() {
    controller = MemoryGameController(
      mismatchDelay: lockHeldDelay,
      random: Random(1234),
    );
  });

  tearDown(() => controller.dispose());

  /// Remplace le controleur par defaut avant que la page ne l'adopte.
  void useMismatchDelay(Duration delay) {
    controller.dispose();
    controller = MemoryGameController(
      mismatchDelay: delay,
      random: Random(1234),
    );
  }

  Future<void> pumpGame(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: MemoryGamePage(controller: controller)),
    );
    await tester.pumpAndSettle();
  }

  /// Retourne la carte a [index] et laisse l'animation de flip se terminer.
  Future<void> tapCard(WidgetTester tester, int index) async {
    await tester.tap(find.byKey(MemoryGamePage.cardKey(index)));
    await tester.pumpAndSettle();
  }

  /// Pompe des frames jusqu'a ce que [condition] soit vraie.
  ///
  /// Sur appareil reel on ne peut pas deduire l'etat d'une duree ecoulee : une
  /// frame lente suffit a decaler le timer. On attend donc l'etat lui-meme,
  /// avec une borne haute pour echouer proprement plutot que de boucler.
  Future<void> pumpUntil(
    WidgetTester tester,
    bool Function() condition, {
    Duration timeout = const Duration(seconds: 30),
    String reason = 'condition',
  }) async {
    final DateTime deadline = DateTime.now().add(timeout);
    while (!condition()) {
      if (DateTime.now().isAfter(deadline)) {
        fail('$reason non atteinte apres ${timeout.inSeconds}s');
      }
      await tester.pump(const Duration(milliseconds: 50));
    }
    await tester.pumpAndSettle();
  }

  /// Indices de deux cartes non encore trouvees qui portent le meme symbole.
  (int, int) findMatchingPair(MemoryGameController controller) {
    final List<MemoryCard> cards = controller.cards;
    for (int i = 0; i < cards.length; i++) {
      if (cards[i].isMatched) continue;
      for (int j = i + 1; j < cards.length; j++) {
        if (cards[j].isMatched) continue;
        if (cards[i].symbol == cards[j].symbol) return (i, j);
      }
    }
    throw StateError('Aucune paire restante sur le plateau');
  }

  /// Indices de deux cartes non encore trouvees de symboles differents.
  (int, int) findMismatchingPair(MemoryGameController controller) {
    final List<MemoryCard> cards = controller.cards;
    for (int i = 0; i < cards.length; i++) {
      if (cards[i].isMatched) continue;
      for (int j = i + 1; j < cards.length; j++) {
        if (cards[j].isMatched) continue;
        if (cards[i].symbol != cards[j].symbol) return (i, j);
      }
    }
    throw StateError('Aucune paire differente sur le plateau');
  }

  Finder statValue(Key statKey, String value) => find.descendant(
        of: find.byKey(statKey),
        matching: find.text(value),
      );

  group('Jeu de memoire - niveau 1', () {
    testWidgets('demarre avec toutes les cartes face cachee', (
      WidgetTester tester,
    ) async {
      await pumpGame(tester);

      expect(find.byType(MemoryCardTile), findsNWidgets(12));
      expect(find.byIcon(Icons.help_outline), findsNWidgets(12));
      for (final MemoryCard card in controller.cards) {
        expect(card.isRevealed, isFalse);
      }
      expect(statValue(MemoryGamePage.movesStatKey, '0'), findsOneWidget);
      expect(statValue(MemoryGamePage.pairsStatKey, '0/6'), findsOneWidget);
      expect(find.byKey(MemoryGamePage.victoryPanelKey), findsNothing);
    });

    testWidgets('retourner une carte revele son symbole', (
      WidgetTester tester,
    ) async {
      await pumpGame(tester);

      final String symbol = controller.cards.first.symbol;
      await tapCard(tester, 0);

      expect(controller.cards[0].isFaceUp, isTrue);
      expect(find.byIcon(Icons.help_outline), findsNWidgets(11));
      // Le symbole est visible : au moins cette carte l'affiche.
      expect(find.text(symbol), findsWidgets);
      // Retourner une seule carte ne compte pas comme un coup.
      expect(statValue(MemoryGamePage.movesStatKey, '0'), findsOneWidget);
    });

    testWidgets('une paire identique reste visible et incremente le score', (
      WidgetTester tester,
    ) async {
      // Fenetre courte : on veut depasser reellement le delai de retournement
      // pour prouver qu'aucun timer ne vient cacher la paire trouvee.
      useMismatchDelay(lockReleasedDelay);
      await pumpGame(tester);

      final (int first, int second) = findMatchingPair(controller);
      await tapCard(tester, first);
      await tapCard(tester, second);

      expect(controller.cards[first].isMatched, isTrue);
      expect(controller.cards[second].isMatched, isTrue);
      expect(controller.matchedPairs, 1);
      expect(statValue(MemoryGamePage.movesStatKey, '1'), findsOneWidget);
      expect(statValue(MemoryGamePage.pairsStatKey, '1/6'), findsOneWidget);

      // Une paire trouvee n'arme aucun timer : rien ne peut la retourner.
      expect(controller.isLocked, isFalse);
      await tester.pump(lockReleasedDelay * 3);
      await tester.pumpAndSettle();
      expect(controller.cards[first].isRevealed, isTrue);
      expect(controller.cards[second].isRevealed, isTrue);
      expect(find.byIcon(Icons.help_outline), findsNWidgets(10));
    });

    testWidgets('deux cartes differentes restent visibles et verrouillent le plateau', (
      WidgetTester tester,
    ) async {
      // Fenetre hors d'atteinte : ces assertions decrivent l'etat verrouille,
      // elles ne doivent pas courir contre le timer de retournement.
      useMismatchDelay(lockHeldDelay);
      await pumpGame(tester);

      final (int first, int second) = findMismatchingPair(controller);
      final int third = List<int>.generate(controller.cards.length, (int i) => i)
          .firstWhere((int i) => i != first && i != second);

      await tapCard(tester, first);
      await tapCard(tester, second);

      // Les deux cartes sont visibles le temps que le joueur les memorise.
      expect(controller.cards[first].isFaceUp, isTrue);
      expect(controller.cards[second].isFaceUp, isTrue);
      expect(controller.isLocked, isTrue);
      expect(statValue(MemoryGamePage.movesStatKey, '1'), findsOneWidget);

      // Pendant le verrouillage, une troisieme carte ne se retourne pas.
      await tapCard(tester, third);
      expect(controller.cards[third].isFaceUp, isFalse);
      expect(controller.matchedPairs, 0);
      expect(statValue(MemoryGamePage.movesStatKey, '1'), findsOneWidget);
    });

    testWidgets('deux cartes differentes se retournent apres le delai', (
      WidgetTester tester,
    ) async {
      useMismatchDelay(lockReleasedDelay);
      await pumpGame(tester);

      final (int first, int second) = findMismatchingPair(controller);

      await tapCard(tester, first);
      await tapCard(tester, second);

      // On attend l'etat, jamais une duree : le delai peut deja s'etre ecoule
      // pendant les taps sans invalider ce que le test verifie.
      await pumpUntil(
        tester,
        () => !controller.isLocked,
        reason: 'retournement de la paire ratee',
      );

      expect(controller.cards[first].isFaceUp, isFalse);
      expect(controller.cards[second].isFaceUp, isFalse);
      expect(controller.matchedPairs, 0);
      expect(find.byIcon(Icons.help_outline), findsNWidgets(12));
    });

    testWidgets('trouver toutes les paires affiche l ecran de victoire', (
      WidgetTester tester,
    ) async {
      await pumpGame(tester);

      for (int pair = 0; pair < controller.totalPairs; pair++) {
        final (int first, int second) = findMatchingPair(controller);
        await tapCard(tester, first);
        await tapCard(tester, second);
      }

      expect(controller.status, MemoryGameStatus.won);
      expect(controller.matchedPairs, 6);
      expect(statValue(MemoryGamePage.pairsStatKey, '6/6'), findsOneWidget);
      expect(find.byKey(MemoryGamePage.victoryPanelKey), findsOneWidget);
      expect(find.text('Bravo !'), findsOneWidget);
      expect(find.text('Niveau 1 termine en 6 coups'), findsOneWidget);
      expect(find.byIcon(Icons.help_outline), findsNothing);
    });

    testWidgets('rejouer depuis l ecran de victoire relance une partie', (
      WidgetTester tester,
    ) async {
      await pumpGame(tester);

      for (int pair = 0; pair < controller.totalPairs; pair++) {
        final (int first, int second) = findMatchingPair(controller);
        await tapCard(tester, first);
        await tapCard(tester, second);
      }
      expect(find.byKey(MemoryGamePage.victoryPanelKey), findsOneWidget);

      await tester.tap(find.byKey(MemoryGamePage.victoryReplayButtonKey));
      await tester.pumpAndSettle();

      expect(find.byKey(MemoryGamePage.victoryPanelKey), findsNothing);
      expect(controller.status, MemoryGameStatus.playing);
      expect(controller.moves, 0);
      expect(controller.matchedPairs, 0);
      expect(find.byIcon(Icons.help_outline), findsNWidgets(12));
      expect(statValue(MemoryGamePage.movesStatKey, '0'), findsOneWidget);
      expect(statValue(MemoryGamePage.pairsStatKey, '0/6'), findsOneWidget);
    });

    testWidgets('le bouton rejouer de la barre remet la partie a zero', (
      WidgetTester tester,
    ) async {
      await pumpGame(tester);

      final (int first, int second) = findMatchingPair(controller);
      await tapCard(tester, first);
      await tapCard(tester, second);
      expect(controller.matchedPairs, 1);

      await tester.tap(find.byKey(MemoryGamePage.restartButtonKey));
      await tester.pumpAndSettle();

      expect(controller.moves, 0);
      expect(controller.matchedPairs, 0);
      expect(find.byIcon(Icons.help_outline), findsNWidgets(12));
    });
  });

  testWidgets('l application demarre directement sur le jeu de memoire', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(MemoryGamePage), findsOneWidget);
    expect(find.text('Jeu de memoire'), findsOneWidget);
    expect(find.byType(MemoryCardTile), findsNWidgets(12));
  });
}

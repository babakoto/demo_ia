import 'dart:math';

import 'package:demo/core/di/di.dart';
import 'package:demo/layers/application/memory_game/memory_game_bloc.dart';
import 'package:demo/layers/domain/entities/memory_card_entity.dart';
import 'package:demo/layers/domain/repositories/memory_level_repository.dart';
import 'package:demo/layers/presentation/app.dart';
import 'package:demo/layers/presentation/pages/memory_game/memory_game_page.dart';
import 'package:demo/layers/presentation/pages/memory_game/widgets/memory_card_tile.dart';
import 'package:demo/layers/presentation/utils/memory_game_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Contrairement au binding de `flutter test`, le binding d'integration
  // s'appuie sur l'horloge reelle : le delai de retournement court pendant que
  // le test execute ses assertions. Plutot que de parier sur un delai "assez
  // grand pour tenir", chaque test choisit la fenetre qui rend son assertion
  // deterministe.

  /// Fenetre volontairement hors d'atteinte : le verrou ne peut pas se relacher
  /// pendant qu'on verifie qu'il tient, meme sur un build debug lent.
  const Duration lockHeldDelay = Duration(minutes: 10);

  /// Fenetre courte : les tests qui attendent le relachement attendent l'etat
  /// (via [pumpUntil]) et non la duree, une frame lente ne les met pas en echec.
  const Duration lockReleasedDelay = Duration(milliseconds: 300);

  late MemoryGameBloc bloc;

  setUpAll(() => configureDependencies());

  /// Monte la page avec un bloc graine : le plateau est reproductible et le
  /// delai de retournement est choisi par le test.
  Future<void> pumpGame(
    WidgetTester tester, {
    required Duration mismatchDelay,
  }) async {
    bloc = MemoryGameBloc(
      memoryLevelRepository: getIt<MemoryLevelRepository>(),
      random: Random(1234),
      mismatchDelay: mismatchDelay,
    )..add(const OnStartGame());
    addTearDown(bloc.close);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<MemoryGameBloc>.value(
          value: bloc,
          child: const MemoryGamePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Retourne la carte a [index] et laisse l'animation de flip se terminer.
  Future<void> tapCard(WidgetTester tester, int index) async {
    await tester.tap(find.byKey(MemoryGameKeys.card(index)));
    await tester.pumpAndSettle();
  }

  /// Pompe des frames jusqu'a ce que [condition] soit vraie.
  ///
  /// Sur appareil reel on ne peut pas deduire l'etat d'une duree ecoulee : une
  /// frame lente suffit a decaler le retournement. On attend donc l'etat
  /// lui-meme, avec une borne haute pour echouer proprement.
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

  /// Indices de deux cartes non encore retournees, de meme symbole ou non.
  (int, int) pickPair({required bool sameSymbol}) {
    final List<MemoryCardEntity> cards = bloc.state.board.cards;
    for (int i = 0; i < cards.length; i++) {
      if (cards[i].isRevealed) continue;
      for (int j = i + 1; j < cards.length; j++) {
        if (cards[j].isRevealed) continue;
        if ((cards[i].symbol == cards[j].symbol) == sameSymbol) return (i, j);
      }
    }
    throw StateError('Aucune paire exploitable sur le plateau');
  }

  Finder statValue(Key statKey, String value) => find.descendant(
        of: find.byKey(statKey),
        matching: find.text(value),
      );

  group('Jeu de memoire - niveau 1', () {
    testWidgets('demarre avec toutes les cartes face cachee', (
      WidgetTester tester,
    ) async {
      await pumpGame(tester, mismatchDelay: lockHeldDelay);

      expect(find.byType(MemoryCardTile), findsNWidgets(12));
      expect(find.byIcon(Icons.help_outline), findsNWidgets(12));
      for (final MemoryCardEntity card in bloc.state.board.cards) {
        expect(card.isRevealed, isFalse);
      }
      expect(statValue(MemoryGameKeys.movesStat, '0'), findsOneWidget);
      expect(statValue(MemoryGameKeys.pairsStat, '0/6'), findsOneWidget);
      expect(find.byKey(MemoryGameKeys.victoryPanel), findsNothing);
      expect(find.byKey(MemoryGameKeys.boardError), findsNothing);
    });

    testWidgets('retourner une carte revele son symbole', (
      WidgetTester tester,
    ) async {
      await pumpGame(tester, mismatchDelay: lockHeldDelay);

      final String symbol = bloc.state.board.cards.first.symbol;
      await tapCard(tester, 0);

      expect(bloc.state.board.cards[0].isFaceUp, isTrue);
      expect(find.byIcon(Icons.help_outline), findsNWidgets(11));
      // Le symbole est visible : au moins cette carte l'affiche.
      expect(find.text(symbol), findsWidgets);
      // Retourner une seule carte ne compte pas comme un coup.
      expect(statValue(MemoryGameKeys.movesStat, '0'), findsOneWidget);
    });

    testWidgets('une paire identique reste visible et incremente le score', (
      WidgetTester tester,
    ) async {
      // Fenetre courte : on veut depasser reellement le delai de retournement
      // pour prouver qu'aucun retournement differe ne cache la paire trouvee.
      await pumpGame(tester, mismatchDelay: lockReleasedDelay);

      final (int first, int second) = pickPair(sameSymbol: true);
      await tapCard(tester, first);
      await tapCard(tester, second);

      expect(bloc.state.board.cards[first].isMatched, isTrue);
      expect(bloc.state.board.cards[second].isMatched, isTrue);
      expect(bloc.state.matchedPairs, 1);
      expect(statValue(MemoryGameKeys.movesStat, '1'), findsOneWidget);
      expect(statValue(MemoryGameKeys.pairsStat, '1/6'), findsOneWidget);

      // Une paire trouvee n'arme aucun retournement : rien ne peut la cacher.
      expect(bloc.state.isLocked, isFalse);
      await tester.pump(lockReleasedDelay * 3);
      await tester.pumpAndSettle();
      expect(bloc.state.board.cards[first].isRevealed, isTrue);
      expect(bloc.state.board.cards[second].isRevealed, isTrue);
      expect(find.byIcon(Icons.help_outline), findsNWidgets(10));
    });

    testWidgets('deux cartes differentes restent visibles et verrouillent le plateau', (
      WidgetTester tester,
    ) async {
      // Fenetre hors d'atteinte : ces assertions decrivent l'etat verrouille,
      // elles ne doivent pas courir contre le retournement differe.
      await pumpGame(tester, mismatchDelay: lockHeldDelay);

      final (int first, int second) = pickPair(sameSymbol: false);
      final int third = List<int>.generate(12, (int i) => i)
          .firstWhere((int i) => i != first && i != second);

      await tapCard(tester, first);
      await tapCard(tester, second);

      // Les deux cartes sont visibles le temps que le joueur les memorise.
      expect(bloc.state.board.cards[first].isFaceUp, isTrue);
      expect(bloc.state.board.cards[second].isFaceUp, isTrue);
      expect(bloc.state.isLocked, isTrue);
      expect(statValue(MemoryGameKeys.movesStat, '1'), findsOneWidget);

      // Pendant le verrouillage, une troisieme carte ne se retourne pas.
      await tapCard(tester, third);
      expect(bloc.state.board.cards[third].isFaceUp, isFalse);
      expect(bloc.state.matchedPairs, 0);
      expect(statValue(MemoryGameKeys.movesStat, '1'), findsOneWidget);
    });

    testWidgets('deux cartes differentes se retournent apres le delai', (
      WidgetTester tester,
    ) async {
      await pumpGame(tester, mismatchDelay: lockReleasedDelay);

      final (int first, int second) = pickPair(sameSymbol: false);

      await tapCard(tester, first);
      await tapCard(tester, second);

      // On attend l'etat, jamais une duree : le delai peut deja s'etre ecoule
      // pendant les taps sans invalider ce que le test verifie.
      await pumpUntil(
        tester,
        () => !bloc.state.isLocked,
        reason: 'retournement de la paire ratee',
      );

      expect(bloc.state.board.cards[first].isFaceUp, isFalse);
      expect(bloc.state.board.cards[second].isFaceUp, isFalse);
      expect(bloc.state.matchedPairs, 0);
      expect(find.byIcon(Icons.help_outline), findsNWidgets(12));
    });

    testWidgets('trouver toutes les paires affiche l ecran de victoire', (
      WidgetTester tester,
    ) async {
      await pumpGame(tester, mismatchDelay: lockHeldDelay);

      for (int pair = 0; pair < bloc.state.totalPairs; pair++) {
        final (int first, int second) = pickPair(sameSymbol: true);
        await tapCard(tester, first);
        await tapCard(tester, second);
      }

      expect(bloc.state.isWon, isTrue);
      expect(bloc.state.matchedPairs, 6);
      expect(statValue(MemoryGameKeys.pairsStat, '6/6'), findsOneWidget);
      expect(find.byKey(MemoryGameKeys.victoryPanel), findsOneWidget);
      expect(find.text('Bravo !'), findsOneWidget);
      expect(find.text('Niveau 1 termine en 6 coups'), findsOneWidget);
      expect(find.byIcon(Icons.help_outline), findsNothing);
    });

    testWidgets('rejouer depuis l ecran de victoire relance une partie', (
      WidgetTester tester,
    ) async {
      await pumpGame(tester, mismatchDelay: lockHeldDelay);

      for (int pair = 0; pair < bloc.state.totalPairs; pair++) {
        final (int first, int second) = pickPair(sameSymbol: true);
        await tapCard(tester, first);
        await tapCard(tester, second);
      }
      expect(find.byKey(MemoryGameKeys.victoryPanel), findsOneWidget);

      await tester.tap(find.byKey(MemoryGameKeys.victoryReplayButton));
      await tester.pumpAndSettle();

      expect(find.byKey(MemoryGameKeys.victoryPanel), findsNothing);
      expect(bloc.state.isWon, isFalse);
      expect(bloc.state.moves, 0);
      expect(bloc.state.matchedPairs, 0);
      expect(find.byIcon(Icons.help_outline), findsNWidgets(12));
      expect(statValue(MemoryGameKeys.movesStat, '0'), findsOneWidget);
      expect(statValue(MemoryGameKeys.pairsStat, '0/6'), findsOneWidget);
    });

    testWidgets('le bouton rejouer de la barre remet la partie a zero', (
      WidgetTester tester,
    ) async {
      await pumpGame(tester, mismatchDelay: lockHeldDelay);

      final (int first, int second) = pickPair(sameSymbol: true);
      await tapCard(tester, first);
      await tapCard(tester, second);
      expect(bloc.state.matchedPairs, 1);

      await tester.tap(find.byKey(MemoryGameKeys.restartButton));
      await tester.pumpAndSettle();

      expect(bloc.state.moves, 0);
      expect(bloc.state.matchedPairs, 0);
      expect(find.byIcon(Icons.help_outline), findsNWidgets(12));
    });

    testWidgets('rejouer pendant le verrou rend la main au joueur', (
      WidgetTester tester,
    ) async {
      // Le verrou ne peut pas tomber tout seul : s'il se libere, c'est bien le
      // bouton rejouer qui l'a fait.
      await pumpGame(tester, mismatchDelay: lockHeldDelay);

      final (int first, int second) = pickPair(sameSymbol: false);
      await tapCard(tester, first);
      await tapCard(tester, second);
      expect(bloc.state.isLocked, isTrue);

      await tester.tap(find.byKey(MemoryGameKeys.restartButton));
      await tester.pumpAndSettle();

      expect(bloc.state.isLocked, isFalse);
      expect(find.byIcon(Icons.help_outline), findsNWidgets(12));

      // Le nouveau plateau repond immediatement.
      await tapCard(tester, 0);
      expect(bloc.state.board.cards[0].isFaceUp, isTrue);
      expect(find.byIcon(Icons.help_outline), findsNWidgets(11));
    });
  });

  testWidgets('l application demarre directement sur le jeu de memoire', (
    WidgetTester tester,
  ) async {
    // Parcours complet : injection de dependances, BlocRegister, page.
    await tester.pumpWidget(const MemoryApp());
    await tester.pumpAndSettle();

    expect(find.byType(MemoryGamePage), findsOneWidget);
    expect(find.text('Jeu de memoire'), findsOneWidget);
    expect(find.byType(MemoryCardTile), findsNWidgets(12));
    expect(find.byKey(MemoryGameKeys.boardLoader), findsNothing);
    expect(find.byKey(MemoryGameKeys.boardError), findsNothing);
  });
}

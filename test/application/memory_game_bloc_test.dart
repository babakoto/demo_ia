import 'dart:math';

import 'package:demo/core/errors/app_failures.dart';
import 'package:demo/core/utils/bloc_result.dart';
import 'package:demo/layers/application/memory_game/memory_game_bloc.dart';
import 'package:demo/layers/application/memory_game/memory_game_state.dart';
import 'package:demo/layers/data/repositories/memory_level_repository_imp.dart';
import 'package:demo/layers/data/sources/locals/memory_level_local_source.dart';
import 'package:demo/layers/domain/entities/memory_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/board_helpers.dart';

void main() {
  const Duration mismatchDelay = Duration(milliseconds: 60);

  late MemoryGameBloc bloc;

  // Le repository est celui de production : sa source est locale, il n'y a
  // rien a simuler pour obtenir un comportement deterministe.
  MemoryGameBloc buildBloc() => MemoryGameBloc(
        memoryLevelRepository: const MemoryLevelRepositoryImp(
          MemoryLevelLocalSource(),
        ),
        random: Random(1234),
        mismatchDelay: mismatchDelay,
      );

  /// Attend que [predicate] soit vrai, ou echoue au bout de 5 secondes.
  Future<void> until(bool Function(MemoryGameState state) predicate) async {
    if (predicate(bloc.state)) return;
    await bloc.stream
        .firstWhere(predicate)
        .timeout(const Duration(seconds: 5));
  }

  Future<void> startGame() async {
    bloc.add(const OnStartGame());
    await until((MemoryGameState state) => state.status.isSuccess);
  }

  setUp(() => bloc = buildBloc());
  tearDown(() => bloc.close());

  test('demarre sur un plateau face cachee', () async {
    expect(bloc.state.status, BlocStatus.initial);

    await startGame();

    expect(bloc.state.level?.label, 'Niveau 1');
    expect(bloc.state.board.cards, hasLength(12));
    expect(bloc.state.totalPairs, 6);
    expect(bloc.state.moves, 0);
    expect(bloc.state.isWon, isFalse);
    expect(bloc.state.isLocked, isFalse);
  });

  test('un niveau inconnu remonte une Failure typee', () async {
    bloc.add(const OnStartGame(levelId: 'level-inconnu'));
    await until((MemoryGameState state) => state.status.isFailure);

    expect(bloc.state.failure, isA<LevelNotFoundFailure>());
    expect(bloc.state.board.cards, isEmpty);
  });

  test('une paire identique est validee sans verrouiller le plateau', () async {
    await startGame();
    final (int first, int second) = matchingPair(bloc.state.board);

    bloc.add(OnFlipCard(first));
    await until((MemoryGameState state) => state.board.firstPick == first);
    bloc.add(OnFlipCard(second));
    await until((MemoryGameState state) => state.matchedPairs == 1);

    expect(bloc.state.moves, 1);
    expect(bloc.state.isLocked, isFalse);
    expect(bloc.state.board.cards[first].isMatched, isTrue);
    expect(bloc.state.board.cards[second].isMatched, isTrue);
  });

  test('une paire differente verrouille puis se retourne seule', () async {
    await startGame();
    final (int first, int second) = mismatchingPair(bloc.state.board);

    bloc.add(OnFlipCard(first));
    await until((MemoryGameState state) => state.board.firstPick == first);
    bloc.add(OnFlipCard(second));
    await until((MemoryGameState state) => state.isLocked);

    expect(bloc.state.moves, 1);
    expect(bloc.state.board.cards[first].isFaceUp, isTrue);
    expect(bloc.state.board.cards[second].isFaceUp, isTrue);

    // Pendant le verrou, une troisieme carte ne se retourne pas.
    final int third = List<int>.generate(12, (int i) => i)
        .firstWhere((int i) => i != first && i != second);
    bloc.add(OnFlipCard(third));
    await until((MemoryGameState state) => !state.isLocked);

    expect(bloc.state.board.cards[first].isFaceUp, isFalse);
    expect(bloc.state.board.cards[second].isFaceUp, isFalse);
    expect(bloc.state.board.cards[third].isFaceUp, isFalse);
    expect(bloc.state.moves, 1);
  });

  test('rejouer redistribue et ouvre une nouvelle manche', () async {
    await startGame();
    final int round = bloc.state.round;
    final (int first, int second) = matchingPair(bloc.state.board);
    bloc.add(OnFlipCard(first));
    await until((MemoryGameState state) => state.board.firstPick == first);
    bloc.add(OnFlipCard(second));
    await until((MemoryGameState state) => state.matchedPairs == 1);

    bloc.add(const OnRestartGame());
    await until((MemoryGameState state) => state.round == round + 1);

    expect(bloc.state.moves, 0);
    expect(bloc.state.matchedPairs, 0);
    expect(bloc.state.isLocked, isFalse);
    expect(
      bloc.state.board.cards.every((MemoryCardEntity c) => !c.isRevealed),
      isTrue,
    );
  });

  test(
    'un retournement differe ne touche pas le plateau redistribue entre-temps',
    () async {
      await startGame();
      final (int first, int second) = mismatchingPair(bloc.state.board);
      bloc.add(OnFlipCard(first));
      await until((MemoryGameState state) => state.board.firstPick == first);
      bloc.add(OnFlipCard(second));
      await until((MemoryGameState state) => state.isLocked);

      // Le joueur relance avant la fin du delai : le verrou tombe tout de
      // suite et la manche change.
      final int round = bloc.state.round;
      bloc.add(const OnRestartGame());
      await until((MemoryGameState state) => state.round == round + 1);
      expect(bloc.state.isLocked, isFalse);

      // Le joueur repart immediatement sur une paire ratee du nouveau plateau.
      final (int newFirst, int newSecond) = mismatchingPair(bloc.state.board);
      bloc.add(OnFlipCard(newFirst));
      await until((MemoryGameState state) => state.board.firstPick == newFirst);
      bloc.add(OnFlipCard(newSecond));
      await until((MemoryGameState state) => state.isLocked);

      // Le retournement arme sur la manche precedente ne doit pas liberer
      // celle-ci : les deux cartes restent visibles le temps prevu.
      await Future<void>.delayed(mismatchDelay ~/ 2);
      expect(bloc.state.isLocked, isTrue);
      expect(bloc.state.board.cards[newFirst].isFaceUp, isTrue);

      await until((MemoryGameState state) => !state.isLocked);
      expect(bloc.state.board.cards[newFirst].isFaceUp, isFalse);
      expect(bloc.state.board.cards[newSecond].isFaceUp, isFalse);
    },
  );

  test('trouver toutes les paires gagne la partie', () async {
    await startGame();

    for (int pair = 0; pair < bloc.state.totalPairs; pair++) {
      final (int first, int second) = matchingPair(bloc.state.board);
      bloc.add(OnFlipCard(first));
      await until((MemoryGameState state) => state.board.firstPick == first);
      bloc.add(OnFlipCard(second));
      await until((MemoryGameState state) => state.matchedPairs == pair + 1);
    }

    expect(bloc.state.isWon, isTrue);
    expect(bloc.state.moves, 6);

    // Une partie gagnee n'accepte plus de tap.
    bloc.add(const OnFlipCard(0));
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state.moves, 6);
  });

  test('rejouer avant le chargement d un niveau ne fait rien', () async {
    bloc.add(const OnRestartGame());
    await Future<void>.delayed(Duration.zero);

    expect(bloc.state.status, BlocStatus.initial);
    expect(bloc.state.board.cards, isEmpty);
  });

  test('le niveau du catalogue correspond au niveau de reference', () async {
    await startGame();

    expect(bloc.state.level, testLevel);
  });
}

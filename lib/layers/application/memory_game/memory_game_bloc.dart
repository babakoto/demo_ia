import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fos/fos.dart';

import '../../../core/constants/app_durations.dart';
import '../../../core/utils/bloc_result.dart';
import '../../domain/entities/memory_board_entity.dart';
import '../../domain/entities/memory_level_entity.dart';
import '../../domain/repositories/memory_level_repository.dart';
import 'memory_game_state.dart';

part 'memory_game_event.dart';

/// Orchestre une partie : charge le niveau, enchaine les transitions pures du
/// [MemoryBoardEntity] et gere le seul effet de bord du jeu, le delai avant de
/// recacher une paire ratee.
class MemoryGameBloc extends Bloc<MemoryGameEvent, MemoryGameState> {
  MemoryGameBloc({
    required this.memoryLevelRepository,
    required this.random,
    this.mismatchDelay = AppDurations.mismatchDelay,
  }) : super(const MemoryGameState()) {
    on<OnStartGame>(_onStartGame, transformer: droppable());
    on<OnRestartGame>(_onRestartGame, transformer: droppable());
    // `concurrent` et non `sequential` : le handler d'une paire ratee attend la
    // fin du delai de retournement, les taps suivants ne doivent pas faire la
    // queue derriere lui. Le verrou est porte par `state.isLocked`, ce qui le
    // rend lisible par l'UI et annulable par un `OnRestartGame`.
    on<OnFlipCard>(_onFlipCard, transformer: concurrent());
  }

  final MemoryLevelRepository memoryLevelRepository;

  /// Source d'alea du melange.
  final Random random;

  /// Temps pendant lequel une paire ratee reste visible avant de se retourner.
  final Duration mismatchDelay;

  Future<void> _onStartGame(
    OnStartGame event,
    Emitter<MemoryGameState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading, failure: null));

    final Fos<Failure, MemoryLevelEntity> result =
        await memoryLevelRepository.getLevel(id: event.levelId);

    result.on(
      (Failure failure) => emit(
        state.copyWith(status: BlocStatus.failure, failure: failure),
      ),
      (MemoryLevelEntity level) => emit(_deal(level)),
    );
  }

  Future<void> _onRestartGame(
    OnRestartGame event,
    Emitter<MemoryGameState> emit,
  ) async {
    final MemoryLevelEntity? level = state.level;
    if (level == null) return;
    emit(_deal(level));
  }

  Future<void> _onFlipCard(
    OnFlipCard event,
    Emitter<MemoryGameState> emit,
  ) async {
    if (!state.status.isSuccess || state.isLocked) return;

    final MemoryBoardEntity board = state.board.flip(event.index);
    // Tap sans effet (carte deja visible, index hors plateau, partie gagnee).
    if (board == state.board) return;

    final bool isMismatch = board.hasPendingMismatch;
    emit(state.copyWith(board: board, isLocked: isMismatch));
    if (!isMismatch) return;

    final int round = state.round;
    await Future<void>.delayed(mismatchDelay);

    // Le bloc a pu etre ferme, ou la partie relancee, pendant l'attente : dans
    // les deux cas ce retournement ne concerne plus le plateau affiche.
    if (emit.isDone || state.round != round) return;
    emit(
      state.copyWith(
        board: state.board.hidePendingMismatch(),
        isLocked: false,
      ),
    );
  }

  /// Distribue un plateau neuf pour [level] et ouvre une nouvelle manche.
  MemoryGameState _deal(MemoryLevelEntity level) => state.copyWith(
        status: BlocStatus.success,
        level: level,
        board: MemoryBoardEntity.deal(level: level, random: random),
        isLocked: false,
        round: state.round + 1,
        failure: null,
      );
}

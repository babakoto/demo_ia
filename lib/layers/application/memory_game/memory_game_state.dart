import 'package:fos/fos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/bloc_result.dart';
import '../../domain/entities/memory_board_entity.dart';
import '../../domain/entities/memory_level_entity.dart';

part 'memory_game_state.freezed.dart';

@freezed
abstract class MemoryGameState with _$MemoryGameState {
  const MemoryGameState._();

  const factory MemoryGameState({
    @Default(BlocStatus.initial) BlocStatus status,
    @Default(MemoryBoardEntity()) MemoryBoardEntity board,
    MemoryLevelEntity? level,

    /// Vrai tant que la paire ratee est affichee : les taps sont ignores.
    @Default(false) bool isLocked,

    /// Numero de la manche en cours.
    ///
    /// Incremente a chaque distribution, il permet a un retournement differe de
    /// savoir que son plateau n'existe plus (redistribution pendant l'attente).
    @Default(0) int round,
    Failure? failure,
  }) = _MemoryGameState;

  int get moves => board.moves;

  int get matchedPairs => board.matchedPairs;

  int get totalPairs => board.totalPairs;

  /// Toutes les paires ont ete trouvees.
  bool get isWon => board.isComplete;
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../application/memory_game/memory_game_bloc.dart';
import '../../../application/memory_game/memory_game_state.dart';
import '../../../domain/entities/memory_level_entity.dart';
import '../../utils/memory_game_keys.dart';
import 'widgets/memory_board_view.dart';
import 'widgets/memory_error_view.dart';
import 'widgets/memory_score_board.dart';
import 'widgets/memory_victory_overlay.dart';

/// Ecran principal du jeu de memoire.
class MemoryGamePage extends StatelessWidget {
  const MemoryGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(AppStrings.appTitle),
        actions: <Widget>[
          IconButton(
            key: MemoryGameKeys.restartButton,
            tooltip: AppStrings.replay,
            onPressed: () => _add(context, const OnRestartGame()),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MemoryGameBloc, MemoryGameState>(
          builder: (BuildContext context, MemoryGameState state) {
            if (state.status.isFailure) {
              return MemoryErrorView(
                failure: state.failure,
                onRetry: () => _add(context, const OnStartGame()),
              );
            }

            final MemoryLevelEntity? level = state.level;
            if (!state.status.isSuccess || level == null) {
              return const Center(
                child: CircularProgressIndicator(key: MemoryGameKeys.boardLoader),
              );
            }

            return Column(
              children: <Widget>[
                MemoryScoreBoard(
                  moves: state.moves,
                  matchedPairs: state.matchedPairs,
                  totalPairs: state.totalPairs,
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: MemoryBoardView(
                          level: level,
                          cards: state.board.cards,
                          onFlip: (int index) =>
                              _add(context, OnFlipCard(index)),
                        ),
                      ),
                      if (state.isWon)
                        MemoryVictoryOverlay(
                          levelLabel: level.label,
                          moves: state.moves,
                          onReplay: () => _add(context, const OnRestartGame()),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _add(BuildContext context, MemoryGameEvent event) =>
      context.read<MemoryGameBloc>().add(event);
}

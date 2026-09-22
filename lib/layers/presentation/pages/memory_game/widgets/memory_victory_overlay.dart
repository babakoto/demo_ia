import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../utils/memory_game_keys.dart';

/// Panneau de fin de partie, superpose au plateau.
class MemoryVictoryOverlay extends StatelessWidget {
  const MemoryVictoryOverlay({
    super.key,
    required this.levelLabel,
    required this.moves,
    required this.onReplay,
  });

  final String levelLabel;
  final int moves;
  final VoidCallback onReplay;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Positioned.fill(
      key: MemoryGameKeys.victoryPanel,
      child: ColoredBox(
        color: theme.colorScheme.scrim.withValues(alpha: 0.55),
        child: Center(
          child: Padding(
            padding: const .all(24),
            child: Card(
              child: Padding(
                padding: const .all(24),
                child: Column(
                  mainAxisSize: .min,
                  children: <Widget>[
                    Icon(
                      Icons.emoji_events,
                      size: 48,
                      color: theme.colorScheme.tertiary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.victoryTitle,
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.victorySummary(
                        levelLabel: levelLabel,
                        moves: moves,
                      ),
                      textAlign: .center,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      key: MemoryGameKeys.victoryReplayButton,
                      onPressed: onReplay,
                      icon: const Icon(Icons.replay),
                      label: const Text(AppStrings.replay),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

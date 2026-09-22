import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../utils/memory_game_keys.dart';

/// Bandeau de statistiques affiche au-dessus du plateau.
class MemoryScoreBoard extends StatelessWidget {
  const MemoryScoreBoard({
    super.key,
    required this.moves,
    required this.matchedPairs,
    required this.totalPairs,
  });

  final int moves;
  final int matchedPairs;
  final int totalPairs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .fromLTRB(16, 16, 16, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _StatChip(
              statKey: MemoryGameKeys.movesStat,
              label: AppStrings.movesLabel,
              value: '$moves',
              icon: Icons.touch_app_outlined,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatChip(
              statKey: MemoryGameKeys.pairsStat,
              label: AppStrings.pairsLabel,
              value: '$matchedPairs/$totalPairs',
              icon: Icons.style_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.statKey,
    required this.label,
    required this.value,
    required this.icon,
  });

  final Key statKey;
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      key: statKey,
      padding: const .symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: .circular(12),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: <Widget>[
                Text(label, style: theme.textTheme.labelSmall),
                Text(
                  value,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: .bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

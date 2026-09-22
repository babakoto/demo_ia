import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../domain/entities/memory_card_entity.dart';
import '../../../../domain/entities/memory_level_entity.dart';
import '../../../utils/memory_game_keys.dart';
import 'memory_card_tile.dart';

/// Grille de cartes carrees, dimensionnee pour tenir entierement a l'ecran
/// quelles que soient la taille et l'orientation du telephone.
class MemoryBoardView extends StatelessWidget {
  const MemoryBoardView({
    super.key,
    required this.level,
    required this.cards,
    required this.onFlip,
  });

  static const double _spacing = 12;
  static const double _maxCellSize = 132;

  final MemoryLevelEntity level;
  final List<MemoryCardEntity> cards;
  final ValueChanged<int> onFlip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(16),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double byWidth =
              (constraints.maxWidth - _spacing * (level.columns - 1)) /
                  level.columns;
          final double byHeight =
              (constraints.maxHeight - _spacing * (level.rows - 1)) / level.rows;
          final double cellSize = math.max(
            0.0,
            math.min(_maxCellSize, math.min(byWidth, byHeight)),
          );

          return Center(
            child: SizedBox(
              width: cellSize * level.columns + _spacing * (level.columns - 1),
              height: cellSize * level.rows + _spacing * (level.rows - 1),
              child: Column(
                children: <Widget>[
                  for (int row = 0; row < level.rows; row++) ...<Widget>[
                    if (row > 0) const SizedBox(height: _spacing),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          for (int col = 0; col < level.columns; col++)
                            ...<Widget>[
                              if (col > 0) const SizedBox(width: _spacing),
                              Expanded(
                                child: _buildTile(row * level.columns + col),
                              ),
                            ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTile(int index) {
    if (index >= cards.length) return const SizedBox.shrink();
    return MemoryCardTile(
      key: MemoryGameKeys.card(index),
      card: cards[index],
      onTap: () => onFlip(index),
    );
  }
}

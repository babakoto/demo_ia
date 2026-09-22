import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../localization/language_menu.dart';
import 'memory_card.dart';
import 'memory_card_tile.dart';
import 'memory_game_controller.dart';
import 'memory_level.dart';

/// Ecran principal du jeu de memoire.
class MemoryGamePage extends StatefulWidget {
  const MemoryGamePage({super.key, this.controller, this.level});

  /// Controleur injecte (tests). Si absent, la page en cree un.
  final MemoryGameController? controller;

  /// Niveau a jouer lorsque [controller] n'est pas fourni.
  final MemoryLevel? level;

  /// Cle de la carte affichee a la position [index] de la grille.
  static ValueKey<String> cardKey(int index) => ValueKey<String>('memory-card-$index');

  static const ValueKey<String> restartButtonKey = ValueKey<String>('restart-button');
  static const ValueKey<String> victoryPanelKey = ValueKey<String>('victory-panel');
  static const ValueKey<String> victoryReplayButtonKey =
      ValueKey<String>('victory-replay-button');
  static const ValueKey<String> movesStatKey = ValueKey<String>('stat-moves');
  static const ValueKey<String> pairsStatKey = ValueKey<String>('stat-pairs');

  @override
  State<MemoryGamePage> createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  /// Vrai lorsque le controleur a ete cree ici : lui seul doit etre libere.
  late bool _ownsController;
  late MemoryGameController _controller;

  @override
  void initState() {
    super.initState();
    _adoptController();
  }

  @override
  void didUpdateWidget(covariant MemoryGamePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Le State est reutilise lorsque la page est repompee au meme endroit de
    // l'arbre : sans cela on continuerait d'ecouter l'ancien controleur, qui
    // peut deja avoir ete libere par l'appelant.
    final bool controllerChanged = widget.controller != oldWidget.controller;
    final bool levelChanged =
        widget.controller == null && widget.level != oldWidget.level;
    if (controllerChanged || levelChanged) {
      _releaseController();
      _adoptController();
    }
  }

  void _adoptController() {
    _ownsController = widget.controller == null;
    _controller = widget.controller ??
        MemoryGameController(level: widget.level ?? .level1);
  }

  void _releaseController() {
    if (_ownsController) {
      _controller.dispose();
    }
  }

  @override
  void dispose() {
    _releaseController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MemoryLevel level = _controller.level;
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l10n.appTitle),
        actions: <Widget>[
          const LanguageMenu(),
          IconButton(
            key: MemoryGamePage.restartButtonKey,
            tooltip: l10n.restartTooltip,
            onPressed: _controller.restart,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Column(
              children: <Widget>[
                _ScoreBoard(controller: _controller),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(child: _buildBoard(level)),
                      if (_controller.status == .won)
                        _VictoryOverlay(
                          level: level,
                          moves: _controller.moves,
                          onReplay: _controller.restart,
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

  /// Grille de cartes carrees, dimensionnee pour tenir entierement a l'ecran
  /// quelles que soient la taille et l'orientation du telephone.
  Widget _buildBoard(MemoryLevel level) {
    final List<MemoryCard> cards = _controller.cards;
    const double spacing = 12;
    const double maxCellSize = 132;

    return Padding(
      padding: const .all(16),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double byWidth =
              (constraints.maxWidth - spacing * (level.columns - 1)) /
                  level.columns;
          final double byHeight =
              (constraints.maxHeight - spacing * (level.rows - 1)) / level.rows;
          final double cellSize =
              math.max(0.0, math.min(maxCellSize, math.min(byWidth, byHeight)));

          return Center(
            child: SizedBox(
              width: cellSize * level.columns + spacing * (level.columns - 1),
              height: cellSize * level.rows + spacing * (level.rows - 1),
              child: Column(
                children: <Widget>[
                  for (int row = 0; row < level.rows; row++) ...<Widget>[
                    if (row > 0) const SizedBox(height: spacing),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          for (int col = 0; col < level.columns; col++)
                            ...<Widget>[
                              if (col > 0) const SizedBox(width: spacing),
                              Expanded(
                                child: _buildTile(
                                  cards,
                                  row * level.columns + col,
                                ),
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

  Widget _buildTile(List<MemoryCard> cards, int index) {
    if (index >= cards.length) return const SizedBox.shrink();
    return MemoryCardTile(
      key: MemoryGamePage.cardKey(index),
      card: cards[index],
      onTap: () => _controller.flipCard(index),
    );
  }
}

class _ScoreBoard extends StatelessWidget {
  const _ScoreBoard({required this.controller});

  final MemoryGameController controller;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Padding(
      padding: const .fromLTRB(16, 16, 16, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _StatChip(
              statKey: MemoryGamePage.movesStatKey,
              label: l10n.movesLabel,
              value: '${controller.moves}',
              icon: Icons.touch_app_outlined,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatChip(
              statKey: MemoryGamePage.pairsStatKey,
              label: l10n.pairsLabel,
              value: '${controller.matchedPairs}/${controller.totalPairs}',
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

class _VictoryOverlay extends StatelessWidget {
  const _VictoryOverlay({
    required this.level,
    required this.moves,
    required this.onReplay,
  });

  final MemoryLevel level;
  final int moves;
  final VoidCallback onReplay;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Positioned.fill(
      key: MemoryGamePage.victoryPanelKey,
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
                      l10n.victoryTitle,
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.victoryMessage(l10n.levelLabel(level.number), moves),
                      textAlign: .center,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      key: MemoryGamePage.victoryReplayButtonKey,
                      onPressed: onReplay,
                      icon: const Icon(Icons.replay),
                      label: Text(l10n.victoryReplayLabel),
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

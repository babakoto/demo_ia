import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'memory_card.dart';

/// Une carte tapable, avec une animation de retournement sur l'axe Y.
class MemoryCardTile extends StatelessWidget {
  const MemoryCardTile({
    super.key,
    required this.card,
    required this.onTap,
  });

  static const Duration flipDuration = Duration(milliseconds: 280);

  final MemoryCard card;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool revealed = card.isRevealed;

    return Semantics(
      button: true,
      label: revealed ? 'Carte ${card.symbol}' : 'Carte cachee',
      child: GestureDetector(
        behavior: .opaque,
        onTap: revealed ? null : onTap,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: revealed ? 1 : 0),
          duration: flipDuration,
          curve: Curves.easeInOut,
          builder: (BuildContext context, double value, Widget? child) {
            final bool showFront = value >= 0.5;
            return Transform(
              alignment: .center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015)
                ..rotateY(value * math.pi),
              child: Transform(
                alignment: .center,
                // Contre-rotation pour que le symbole ne soit pas en miroir.
                transform: Matrix4.identity()
                  ..rotateY(showFront ? math.pi : 0.0),
                child: showFront ? _buildFront(context) : _buildBack(context),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBack(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return _CardSurface(
      color: colors.primaryContainer,
      borderColor: colors.primary,
      child: Icon(
        Icons.help_outline,
        color: colors.onPrimaryContainer,
        size: 28,
      ),
    );
  }

  Widget _buildFront(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool matched = card.isMatched;
    return _CardSurface(
      color: matched ? colors.tertiaryContainer : colors.surfaceContainerHighest,
      borderColor: matched ? colors.tertiary : colors.outlineVariant,
      child: Padding(
        padding: const .all(8),
        child: FittedBox(
          child: Text(
            card.symbol,
            style: const TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}

class _CardSurface extends StatelessWidget {
  const _CardSurface({
    required this.color,
    required this.borderColor,
    required this.child,
  });

  final Color color;
  final Color borderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: .circular(14),
        border: .all(color: borderColor, width: 2),
      ),
      child: Center(child: child),
    );
  }
}

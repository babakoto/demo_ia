import 'package:flutter/foundation.dart';

/// Une carte du plateau de jeu.
///
/// Deux cartes portant le meme [symbol] forment une paire. [id] reste unique
/// pour chaque carte afin de pouvoir les distinguer au sein d'une meme paire.
@immutable
class MemoryCard {
  const MemoryCard({
    required this.id,
    required this.symbol,
    this.isFaceUp = false,
    this.isMatched = false,
  });

  final int id;
  final String symbol;

  /// La carte est retournee mais pas encore validee.
  final bool isFaceUp;

  /// La paire a ete trouvee : la carte reste visible jusqu'a la fin.
  final bool isMatched;

  /// Vrai lorsque le symbole doit etre affiche au joueur.
  bool get isRevealed => isFaceUp || isMatched;

  MemoryCard copyWith({bool? isFaceUp, bool? isMatched}) {
    return MemoryCard(
      id: id,
      symbol: symbol,
      isFaceUp: isFaceUp ?? this.isFaceUp,
      isMatched: isMatched ?? this.isMatched,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MemoryCard &&
        other.id == id &&
        other.symbol == symbol &&
        other.isFaceUp == isFaceUp &&
        other.isMatched == isMatched;
  }

  @override
  int get hashCode => Object.hash(id, symbol, isFaceUp, isMatched);

  @override
  String toString() =>
      'MemoryCard(id: $id, symbol: $symbol, faceUp: $isFaceUp, matched: $isMatched)';
}

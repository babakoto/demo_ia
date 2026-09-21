import 'package:flutter/foundation.dart';

/// Configuration d'un niveau du jeu de memoire.
@immutable
class MemoryLevel {
  const MemoryLevel({
    required this.label,
    required this.columns,
    required this.symbols,
  });

  /// Libelle du niveau, affiche au joueur.
  final String label;

  /// Nombre de colonnes de la grille.
  final int columns;

  /// Symboles utilises : un symbole == une paire.
  final List<String> symbols;

  /// Nombre de paires a trouver.
  int get pairCount => symbols.length;

  /// Nombre total de cartes sur le plateau.
  int get cardCount => pairCount * 2;

  /// Nombre de lignes de la grille.
  int get rows => (cardCount / columns).ceil();

  /// Premier niveau : 6 paires sur une grille 3 x 4, confortable en portrait.
  static const MemoryLevel level1 = MemoryLevel(
    label: 'Niveau 1',
    columns: 3,
    symbols: <String>['🐶', '🐱', '🦊', '🐼', '🦁', '🐸'],
  );
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_level_entity.freezed.dart';

/// Configuration d'un niveau du jeu de memoire.
@freezed
abstract class MemoryLevelEntity with _$MemoryLevelEntity {
  const MemoryLevelEntity._();

  const factory MemoryLevelEntity({
    required String id,

    /// Libelle du niveau, affiche au joueur.
    required String label,

    /// Nombre de colonnes de la grille.
    required int columns,

    /// Symboles utilises : un symbole == une paire.
    required List<String> symbols,
  }) = _MemoryLevelEntity;

  /// Niveau joue par defaut au lancement de l'application.
  static const String level1Id = 'level-1';

  /// Nombre de paires a trouver.
  int get pairCount => symbols.length;

  /// Nombre total de cartes sur le plateau.
  int get cardCount => pairCount * 2;

  /// Nombre de lignes de la grille.
  int get rows => (cardCount / columns).ceil();
}

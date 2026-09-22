import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_card_entity.freezed.dart';

/// Une carte du plateau de jeu.
///
/// Deux cartes portant le meme [symbol] forment une paire. [id] reste unique
/// pour chaque carte afin de pouvoir les distinguer au sein d'une meme paire.
@freezed
abstract class MemoryCardEntity with _$MemoryCardEntity {
  const MemoryCardEntity._();

  const factory MemoryCardEntity({
    required int id,
    required String symbol,

    /// La carte est retournee mais pas encore validee.
    @Default(false) bool isFaceUp,

    /// La paire a ete trouvee : la carte reste visible jusqu'a la fin.
    @Default(false) bool isMatched,
  }) = _MemoryCardEntity;

  /// Vrai lorsque le symbole doit etre affiche au joueur.
  bool get isRevealed => isFaceUp || isMatched;
}

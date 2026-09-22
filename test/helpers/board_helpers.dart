import 'package:demo/layers/domain/entities/memory_board_entity.dart';
import 'package:demo/layers/domain/entities/memory_card_entity.dart';
import 'package:demo/layers/domain/entities/memory_level_entity.dart';

/// Niveau de reference des tests : meme forme que le niveau 1 du catalogue.
const MemoryLevelEntity testLevel = MemoryLevelEntity(
  id: MemoryLevelEntity.level1Id,
  label: 'Niveau 1',
  columns: 3,
  symbols: <String>['🐶', '🐱', '🦊', '🐼', '🦁', '🐸'],
);

/// Indices de deux cartes non encore trouvees qui portent le meme symbole.
(int, int) matchingPair(MemoryBoardEntity board) =>
    _pair(board, sameSymbol: true);

/// Indices de deux cartes non encore trouvees de symboles differents.
(int, int) mismatchingPair(MemoryBoardEntity board) =>
    _pair(board, sameSymbol: false);

(int, int) _pair(MemoryBoardEntity board, {required bool sameSymbol}) {
  final List<MemoryCardEntity> cards = board.cards;
  for (int i = 0; i < cards.length; i++) {
    if (cards[i].isRevealed) continue;
    for (int j = i + 1; j < cards.length; j++) {
      if (cards[j].isRevealed) continue;
      if ((cards[i].symbol == cards[j].symbol) == sameSymbol) return (i, j);
    }
  }
  throw StateError(
    sameSymbol
        ? 'Aucune paire restante sur le plateau'
        : 'Aucune paire differente sur le plateau',
  );
}

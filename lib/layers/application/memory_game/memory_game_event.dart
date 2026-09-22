part of 'memory_game_bloc.dart';

sealed class MemoryGameEvent {
  const MemoryGameEvent();
}

/// Charge un niveau et distribue un plateau melange.
class OnStartGame extends MemoryGameEvent {
  const OnStartGame({this.levelId = MemoryLevelEntity.level1Id});

  final String levelId;
}

/// Le joueur tape la carte affichee a la position [index] de la grille.
class OnFlipCard extends MemoryGameEvent {
  const OnFlipCard(this.index);

  final int index;
}

/// Redistribue le niveau courant et remet les compteurs a zero.
class OnRestartGame extends MemoryGameEvent {
  const OnRestartGame();
}

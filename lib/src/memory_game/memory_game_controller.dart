import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'memory_card.dart';
import 'memory_level.dart';

/// Etat global d'une partie.
enum MemoryGameStatus {
  /// La partie est en cours, il reste des paires a trouver.
  playing,

  /// Toutes les paires ont ete trouvees.
  won,
}

/// Regles du jeu de memoire.
///
/// Le controleur ne depend d'aucun widget : il est testable unitairement et
/// notifie l'UI via [ChangeNotifier].
class MemoryGameController extends ChangeNotifier {
  MemoryGameController({
    this.level = .level1,
    this.mismatchDelay = const Duration(milliseconds: 800),
    Random? random,
  }) : _random = random ?? Random() {
    _deal();
  }

  /// Niveau joue.
  final MemoryLevel level;

  /// Temps pendant lequel une paire ratee reste visible avant de se retourner.
  final Duration mismatchDelay;

  final Random _random;

  List<MemoryCard> _cards = <MemoryCard>[];
  int _moves = 0;
  int? _firstPick;
  int? _secondPick;
  Timer? _mismatchTimer;

  /// Le plateau, dans l'ordre d'affichage de la grille.
  List<MemoryCard> get cards => List<MemoryCard>.unmodifiable(_cards);

  /// Nombre de coups joues (un coup == deux cartes retournees).
  int get moves => _moves;

  /// Nombre de paires deja trouvees.
  int get matchedPairs =>
      _cards.where((MemoryCard card) => card.isMatched).length ~/ 2;

  /// Nombre de paires a trouver pour terminer le niveau.
  int get totalPairs => level.pairCount;

  MemoryGameStatus get status =>
      matchedPairs == totalPairs ? .won : .playing;

  /// Vrai tant que la paire ratee n'est pas retournee : les taps sont ignores.
  bool get isLocked => _mismatchTimer != null;

  /// Retourne la carte situee a [index].
  ///
  /// Les taps invalides (carte deja visible, partie gagnee, plateau verrouille)
  /// sont ignores sans effet de bord.
  void flipCard(int index) {
    if (index < 0 || index >= _cards.length) return;
    if (isLocked || status == .won) return;

    final MemoryCard card = _cards[index];
    if (card.isRevealed) return;

    _cards[index] = card.copyWith(isFaceUp: true);

    final int? first = _firstPick;
    if (first == null) {
      _firstPick = index;
      notifyListeners();
      return;
    }

    _secondPick = index;
    _moves++;

    if (_cards[first].symbol == card.symbol) {
      _cards[first] = _cards[first].copyWith(isMatched: true);
      _cards[index] = _cards[index].copyWith(isMatched: true);
      _firstPick = null;
      _secondPick = null;
    } else {
      _mismatchTimer = Timer(mismatchDelay, _hideMismatchedPair);
    }
    notifyListeners();
  }

  /// Redistribue un plateau melange et remet les compteurs a zero.
  void restart() {
    _mismatchTimer?.cancel();
    _mismatchTimer = null;
    _deal();
    notifyListeners();
  }

  void _deal() {
    final List<MemoryCard> deck = <MemoryCard>[];
    for (int i = 0; i < level.pairCount; i++) {
      deck
        ..add(MemoryCard(id: i * 2, symbol: level.symbols[i]))
        ..add(MemoryCard(id: i * 2 + 1, symbol: level.symbols[i]));
    }
    deck.shuffle(_random);

    _cards = deck;
    _moves = 0;
    _firstPick = null;
    _secondPick = null;
  }

  void _hideMismatchedPair() {
    _mismatchTimer = null;

    final int? first = _firstPick;
    final int? second = _secondPick;
    _firstPick = null;
    _secondPick = null;

    if (first != null) {
      _cards[first] = _cards[first].copyWith(isFaceUp: false);
    }
    if (second != null) {
      _cards[second] = _cards[second].copyWith(isFaceUp: false);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _mismatchTimer?.cancel();
    _mismatchTimer = null;
    super.dispose();
  }
}

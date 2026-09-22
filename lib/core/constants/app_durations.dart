/// Durees partagees entre les couches.
abstract final class AppDurations {
  /// Temps pendant lequel une paire ratee reste visible avant de se retourner.
  static const Duration mismatchDelay = Duration(milliseconds: 800);

  /// Duree de l'animation de retournement d'une carte.
  static const Duration cardFlip = Duration(milliseconds: 280);
}

/// Libelles affiches par l'application.
///
/// Regroupes ici pour servir de point d'entree unique le jour ou le projet
/// passera a `flutter gen-l10n` : seuls ces accesseurs seront a remplacer.
abstract final class AppStrings {
  static const String appTitle = 'Jeu de memoire';
  static const String replay = 'Rejouer';
  static const String movesLabel = 'Coups';
  static const String pairsLabel = 'Paires';
  static const String victoryTitle = 'Bravo !';
  static const String errorTitle = 'Partie indisponible';
  static const String retry = 'Reessayer';
  static const String hiddenCardHint = 'Carte cachee';

  static String victorySummary({
    required String levelLabel,
    required int moves,
  }) =>
      '$levelLabel termine en $moves coups';

  static String revealedCardHint(String symbol) => 'Carte $symbol';
}

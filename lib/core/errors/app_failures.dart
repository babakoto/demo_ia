import 'package:fos/fos.dart';

/// Le niveau demande n'existe pas dans le catalogue.
///
/// Definie dans `core` parce qu'elle traverse les couches : la couche `data`
/// la produit, la couche `application` la transporte, la `presentation` la lit.
class LevelNotFoundFailure extends Failure {
  const LevelNotFoundFailure({super.message});
}

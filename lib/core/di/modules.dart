import 'dart:math';

import 'package:injectable/injectable.dart';

/// Dependances tierces que l'application ne possede pas.
@module
abstract class Modules {
  /// Source d'alea du melange des cartes.
  ///
  /// Injectee plutot qu'instanciee dans le bloc pour qu'un test puisse la
  /// remplacer par un `Random` graine et obtenir un plateau reproductible.
  @singleton
  Random get random => Random();
}

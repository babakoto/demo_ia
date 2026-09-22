import 'package:fos/fos.dart';

import '../entities/memory_level_entity.dart';

/// Contrat d'acces au catalogue des niveaux.
///
/// La source (catalogue embarque aujourd'hui, API demain) est un detail de la
/// couche `data` : le domaine ne connait que ce contrat.
abstract interface class MemoryLevelRepository {
  /// Le niveau [id], ou une [Failure] s'il est absent du catalogue.
  Success<MemoryLevelEntity> getLevel({required String id});
}

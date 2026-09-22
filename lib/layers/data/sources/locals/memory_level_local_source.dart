import 'package:injectable/injectable.dart';

import '../../errors/memory_exceptions.dart';

/// Catalogue des niveaux embarque dans l'application.
@injectable
class MemoryLevelLocalSource {
  const MemoryLevelLocalSource();

  static const List<Map<String, dynamic>> _catalogue = <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 'level-1',
      'label': 'Niveau 1',
      // 6 paires sur une grille 3 x 4, confortable en portrait.
      'columns': 3,
      'symbols': <String>['🐶', '🐱', '🦊', '🐼', '🦁', '🐸'],
    },
  ];

  Future<Map<String, dynamic>> getLevel(String id) async {
    for (final Map<String, dynamic> level in _catalogue) {
      if (level['id'] == id) return level;
    }
    throw LevelNotFoundException(id);
  }
}

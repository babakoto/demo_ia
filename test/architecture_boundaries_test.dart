import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Garde-fou des frontieres de la clean architecture.
///
/// Remplace `architecture_linter`, dont la contrainte `analyzer <7.0.0` est
/// incompatible avec freezed (voir le commentaire dans `pubspec.yaml`).
/// Les dependances pointent vers l'interieur : `presentation` et `application`
/// ne parlent qu'au `domain`, `data` implemente le `domain`, et le `domain`
/// ignore tout le reste, Flutter compris.
void main() {
  /// Pour chaque couche, les prefixes de chemins (relatifs a `lib/`) et les
  /// paquets qu'elle n'a pas le droit d'importer.
  const Map<String, List<String>> bannedImports = <String, List<String>>{
    'layers/domain': <String>[
      'layers/data',
      'layers/application',
      'layers/presentation',
      'package:flutter/material.dart',
      'package:flutter/cupertino.dart',
      'package:flutter/widgets.dart',
      'package:flutter_bloc/',
    ],
    'layers/data': <String>[
      'layers/application',
      'layers/presentation',
      'package:flutter/material.dart',
      'package:flutter/cupertino.dart',
      'package:flutter/widgets.dart',
      'package:flutter_bloc/',
    ],
    'layers/application': <String>['layers/data', 'layers/presentation'],
    'layers/presentation': <String>['layers/data'],
    'core': <String>['layers/presentation'],
  };

  final RegExp importPattern = RegExp(r'''^\s*import\s+['"]([^'"]+)['"]''');

  /// Chemin de l'import, relatif a `lib/`, ou l'URI telle quelle pour un
  /// paquet externe.
  String resolveImport(File file, String rawImport, Directory libDir) {
    if (!rawImport.startsWith('package:demo/') && rawImport.contains(':')) {
      return rawImport;
    }
    final Uri target = rawImport.startsWith('package:demo/')
        ? Uri.file('${libDir.absolute.path}/')
            .resolve(rawImport.substring('package:demo/'.length))
        : Uri.file(file.absolute.path).resolve(rawImport);
    return target.toFilePath().replaceFirst('${libDir.absolute.path}/', '');
  }

  test('aucune couche n importe une couche interdite', () {
    final Directory libDir = Directory('lib');
    expect(libDir.existsSync(), isTrue, reason: 'lance les tests depuis la racine');

    final List<String> violations = <String>[];

    for (final FileSystemEntity entity in libDir.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      // Le code genere n'a pas a respecter les frontieres.
      if (entity.path.endsWith('.freezed.dart') ||
          entity.path.endsWith('.g.dart') ||
          entity.path.endsWith('.config.dart')) {
        continue;
      }

      final String path =
          entity.absolute.path.replaceFirst('${libDir.absolute.path}/', '');
      final String? layer = bannedImports.keys
          .cast<String?>()
          .firstWhere((String? l) => path.startsWith('$l/'), orElse: () => null);
      if (layer == null) continue;

      for (final String line in entity.readAsLinesSync()) {
        final RegExpMatch? match = importPattern.firstMatch(line);
        if (match == null) continue;

        final String resolved = resolveImport(entity, match.group(1)!, libDir);
        for (final String banned in bannedImports[layer]!) {
          if (resolved.startsWith(banned)) {
            violations.add('$path importe $resolved (interdit pour $layer)');
          }
        }
      }
    }

    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  test('chaque couche attendue existe', () {
    for (final String layer in bannedImports.keys) {
      expect(
        Directory('lib/$layer').existsSync(),
        isTrue,
        reason: 'la couche lib/$layer est absente',
      );
    }
  });
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/memory_level_entity.dart';

part 'memory_level_dto.freezed.dart';

/// Representation brute d'un niveau telle que la stocke la source de donnees.
@freezed
abstract class MemoryLevelDto with _$MemoryLevelDto {
  const MemoryLevelDto._();

  const factory MemoryLevelDto({
    required String id,
    required String label,
    required int columns,
    required List<String> symbols,
  }) = _MemoryLevelDto;

  /// Le catalogue est local aujourd'hui ; ce mapping reste valable si la liste
  /// des niveaux vient un jour d'un asset JSON ou d'une API.
  factory MemoryLevelDto.fromMap(Map<String, dynamic> map) => MemoryLevelDto(
        id: map['id'] as String,
        label: map['label'] as String,
        columns: map['columns'] as int,
        symbols: (map['symbols'] as List<dynamic>).cast<String>(),
      );

  MemoryLevelEntity toEntity() => MemoryLevelEntity(
        id: id,
        label: label,
        columns: columns,
        symbols: symbols,
      );
}

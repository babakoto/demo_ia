import 'package:fos/fos.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/app_failures.dart';
import '../../../core/extensions/error_extension.dart';
import '../../domain/entities/memory_level_entity.dart';
import '../../domain/repositories/memory_level_repository.dart';
import '../dto/memory_level_dto.dart';
import '../errors/memory_exceptions.dart';
import '../sources/locals/memory_level_local_source.dart';

@Injectable(as: MemoryLevelRepository)
class MemoryLevelRepositoryImp implements MemoryLevelRepository {
  const MemoryLevelRepositoryImp(this._localSource);

  final MemoryLevelLocalSource _localSource;

  @override
  Success<MemoryLevelEntity> getLevel({required String id}) => safeCall(() async {
        try {
          final Map<String, dynamic> raw = await _localSource.getLevel(id);
          return Fos<Failure, MemoryLevelEntity>.success(
            MemoryLevelDto.fromMap(raw).toEntity(),
          );
        } on LevelNotFoundException catch (e) {
          return Fos<Failure, MemoryLevelEntity>.failure(
            LevelNotFoundFailure(message: 'Niveau ${e.id} introuvable'),
          );
        }
      });
}

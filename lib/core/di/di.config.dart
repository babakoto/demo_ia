// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:math' as _i407;

import 'package:demo/core/di/modules.dart' as _i229;
import 'package:demo/layers/data/repositories/memory_level_repository_imp.dart'
    as _i527;
import 'package:demo/layers/data/sources/locals/memory_level_local_source.dart'
    as _i720;
import 'package:demo/layers/domain/repositories/memory_level_repository.dart'
    as _i29;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final modules = _$Modules();
    gh.factory<_i720.MemoryLevelLocalSource>(
      () => const _i720.MemoryLevelLocalSource(),
    );
    gh.singleton<_i407.Random>(() => modules.random);
    gh.factory<_i29.MemoryLevelRepository>(
      () => _i527.MemoryLevelRepositoryImp(gh<_i720.MemoryLevelLocalSource>()),
    );
    return this;
  }
}

class _$Modules extends _i229.Modules {}

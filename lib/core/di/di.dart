import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

/// Conteneur unique de l'application.
final GetIt getIt = GetIt.instance;

/// Enregistre les dependances generees par `injectable`.
///
/// Les blocs ne sont volontairement pas enregistres ici : ils sont crees dans
/// `presentation/components/bloc_register.dart` et tirent leurs dependances de
/// [getIt].
@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();
}

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/di.dart';
import '../../application/memory_game/memory_game_bloc.dart';

/// Point unique de creation des blocs applicatifs.
///
/// Les blocs ne sont pas injectables : ils sont construits ici et tirent leurs
/// dependances de `getIt`.
class BlocRegister extends StatelessWidget {
  const BlocRegister({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MemoryGameBloc>(
          create: (BuildContext context) => MemoryGameBloc(
            memoryLevelRepository: getIt(),
            random: getIt(),
          )..add(const OnStartGame()),
        ),
      ],
      child: child,
    );
  }
}

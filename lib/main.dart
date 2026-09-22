import 'package:flutter/widgets.dart';

import 'core/di/di.dart';
import 'layers/presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MemoryApp());
}

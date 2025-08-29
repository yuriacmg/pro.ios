// ignore_for_file: cascade_invocations

import 'package:flutter/widgets.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/config/flavor_config.dart';
import 'package:perubeca/bootstrap.dart';
import 'package:perubeca/firebase_options_dev.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  InitFlavorConfig.appFlavor = Flavor.DEV;

  await bootstrap(
    () => const App(),
    DefaultFirebaseOptions.currentPlatform,
  );
}

import 'package:flutter/widgets.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/config/flavor_config.dart';
import 'package:perubeca/bootstrap.dart';
import 'package:perubeca/firebase_options_prod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  InitFlavorConfig.appFlavor = Flavor.PROD;

  await bootstrap(
    () => const App(),
    DefaultFirebaseOptions.currentPlatform,
  );
}

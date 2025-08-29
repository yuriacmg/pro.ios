import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/config/flavor_config.dart';
import 'package:perubeca/bootstrap.dart';
import 'package:perubeca/firebase_options_stg.dart';

void main() {
  InitFlavorConfig.appFlavor = Flavor.STG;

  bootstrap(() => const App(), DefaultFirebaseOptions.currentPlatform);
}

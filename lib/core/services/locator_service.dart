import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_challenge/core/services/shared_prefs_service.dart';

final locator = GetIt.instance;

Future<void> setupDependencies() async {
  // SERVICES
  final prefeferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPrefsService>(
    SharedPrefsService(prefs: prefeferences)
  );
}
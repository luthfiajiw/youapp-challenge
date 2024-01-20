import 'package:flutter/material.dart';
import 'package:youapp_challenge/app.dart';
import 'package:youapp_challenge/core/services/locator_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await setupDependencies();

  runApp(const App());
}
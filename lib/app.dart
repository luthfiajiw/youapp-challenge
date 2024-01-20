import 'package:flutter/material.dart';
import 'package:youapp_challenge/config/routes/route_pahts.dart';
import 'package:youapp_challenge/config/routes/routes.dart';
import 'package:youapp_challenge/config/theme/dark_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "IndRecord",
      theme: DarkTheme().buildDarkTheme(),
      initialRoute: RoutePaths.splash,
      onGenerateRoute: Routes.generate,
    );
  }
}
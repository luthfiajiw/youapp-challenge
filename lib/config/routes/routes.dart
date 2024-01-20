import 'package:flutter/material.dart';
import 'package:youapp_challenge/config/routes/route_pahts.dart';
import 'package:youapp_challenge/core/screens/splash_screen.dart';
import 'package:youapp_challenge/features/auth/presentation/views/login_view.dart';

class Routes {
  static Route<dynamic>? generate(RouteSettings settings) {
    debugPrint("ROUTE ${settings.name}");

    switch (settings.name) {
      case RoutePaths.splash:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutePaths.splash),
          builder: (context) => const SplashScreen(),
        );
      case RoutePaths.login:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutePaths.login),
          builder: (context) => const LoginView(),
        );
      default:
        break;
    }
    return null;
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youapp_challenge/config/routes/route_pahts.dart';
import 'package:youapp_challenge/core/services/locator_service.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:youapp_challenge/features/auth/presentation/views/login_view.dart';
import 'package:youapp_challenge/features/auth/presentation/views/register_view.dart';
import 'package:youapp_challenge/features/auth/presentation/views/splash_view.dart';
import 'package:youapp_challenge/features/user/presentation/user_view.dart';

class Routes {
  static Route<dynamic>? generate(RouteSettings settings) {
    debugPrint("ROUTE ${settings.name}");

    switch (settings.name) {
      case RoutePaths.splash:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutePaths.splash),
          builder: (context) => const SplashView(),
        );
      case RoutePaths.login:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RoutePaths.login),
          builder: (context) => LoginView(authBloc: locator.get<AuthBloc>()),
        );
      case RoutePaths.register:
        return CupertinoPageRoute(
          settings: const RouteSettings(name: RoutePaths.register),
          builder: (context) => RegisterView(
            authBloc: locator.get<AuthBloc>(),
            formKey: GlobalKey<FormState>(),
          ),
        );
      case RoutePaths.user:
        return CupertinoPageRoute(
          settings: const RouteSettings(name: RoutePaths.user),
          builder: (context) => const UserView(),
        );
      default:
        break;
    }
    return null;
  }
}
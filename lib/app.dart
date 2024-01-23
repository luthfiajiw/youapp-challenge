import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/config/routes/route_pahts.dart';
import 'package:youapp_challenge/config/routes/routes.dart';
import 'package:youapp_challenge/config/theme/dark_theme.dart';
import 'package:youapp_challenge/core/services/locator_service.dart';
import 'package:youapp_challenge/features/auth/presentation/cubit/splash_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (context) => locator.get<SplashCubit>(),
        )
      ],
      child: MaterialApp(
        title: "IndRecord",
        debugShowCheckedModeBanner: false,
        theme: DarkTheme().buildDarkTheme(),
        initialRoute: RoutePaths.splash,
        onGenerateRoute: Routes.generate,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/config/routes/route_pahts.dart';
import 'package:youapp_challenge/config/theme/palette.dart';
import 'package:youapp_challenge/features/auth/presentation/cubit/splash_cubit.dart';
import 'package:youapp_challenge/features/auth/presentation/cubit/splash_state.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      context.read<SplashCubit>().authCheck();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is AccessTokenEmpty) {
          Navigator.pushReplacementNamed(context, RoutePaths.login);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
          Palette.tertiaryDark,
          Palette.primaryDark,
        ])),
        child: Scaffold(
          body: Center(
            child: Image.asset(
              'assets/images/youapp-full.png',
              key: const Key('logo'),
              scale: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

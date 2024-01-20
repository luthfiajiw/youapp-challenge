import 'package:flutter/material.dart';
import 'package:youapp_challenge/config/routes/route_pahts.dart';
import 'package:youapp_challenge/config/theme/palette.dart';
import 'package:youapp_challenge/core/services/locator_service.dart';
import 'package:youapp_challenge/core/services/shared_prefs_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkAuth() async {
    String? accessToken = locator.get<SharedPrefsService>().getAccessToken();

    if (accessToken == null) {
      Navigator.pushReplacementNamed(context, RoutePaths.login);
    } else {
      
    }
  }
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      checkAuth();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Palette.tertiaryDark,
            Palette.primaryDark,
          ]
        )
      ),
      child: Scaffold(
        body: Center(
          child: Image.asset('assets/images/youapp-full.png', scale: 1.5,),
        ),
      ),
    );
  }
}
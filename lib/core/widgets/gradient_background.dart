import 'package:flutter/cupertino.dart';
import 'package:youapp_challenge/config/theme/palette.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Palette.tertiaryDark,
              Palette.secondaryDark,
              Palette.primaryDark,
            ]
          ),
        ),
        child: child,
      ),
    );
  }
}
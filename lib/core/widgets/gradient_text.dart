import 'package:flutter/material.dart';
import 'package:youapp_challenge/config/theme/palette.dart';

class GradientText extends StatelessWidget {
  final Text text;
  const GradientText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            Palette.golden2,
            Palette.golden1,
            Palette.golden4,
            Palette.golden5,
          ]
        ).createShader(bounds);
      },
      child: text
    );
  }
}
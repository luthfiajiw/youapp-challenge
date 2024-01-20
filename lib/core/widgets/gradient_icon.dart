import 'package:flutter/material.dart';
import 'package:youapp_challenge/config/theme/palette.dart';

class GradientIcon extends StatelessWidget {
  final Icon icon;
  const GradientIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            Palette.golden1,
            Palette.golden2,
            Palette.golden3,
            Palette.golden4,
            Palette.golden5,
            Palette.golden3,
            Palette.golden5,
          ]
        ).createShader(bounds);
      },
      child: icon
    );
  }
}
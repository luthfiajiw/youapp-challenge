import 'package:flutter/material.dart';
import 'package:youapp_challenge/config/theme/palette.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final bool? isLoading;
  final bool? disabled;
  final Widget child;

  const GradientButton({
    super.key,
    this.onTap,
    this.padding,
    this.isLoading = false,
    this.disabled = false,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        boxShadow: onTap == null || isLoading! || disabled!
        ? null 
        : [
          BoxShadow(
            color: Palette.blue1.withOpacity(.2),
            spreadRadius: 4,
            blurRadius: 10,
            offset: const Offset(0, 8)
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Palette.blue1,
            Palette.blue2
          ]
        )
      ),
      child: Stack(
        children: [
          Material(
            borderRadius: BorderRadius.circular(9),
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9)
              ),
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 50
                ),
                alignment: Alignment.center,
                padding: padding ?? const EdgeInsets.all(16.0),
                child: onTap == null || isLoading! ? null : child,
              ),
            ),
          ),
          Visibility(
            visible: onTap == null || isLoading! || disabled!,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxHeight: 50),
              padding: padding ?? const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(9)
              ),
            ),
          ),
          if (isLoading!) Container(
            constraints: const BoxConstraints(maxHeight: 50),
            alignment: Alignment.center,
            child: const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
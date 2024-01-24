import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final Widget child;

  const CustomChip({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.05),
        borderRadius: BorderRadius.circular(24)
      ),
      child: child,
    );
  }
}
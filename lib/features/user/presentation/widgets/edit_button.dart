import 'package:flutter/material.dart';
import 'package:youapp_challenge/core/widgets/gradient_icon.dart';

class EditButton extends StatelessWidget {
  final VoidCallback? onTap;

  const EditButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: GradientIcon(
          icon: Icon(
            Icons.drive_file_rename_outline_outlined,
            size: 22,
            weight: .5,
          ),
        ),
      ),
    );
  }
}
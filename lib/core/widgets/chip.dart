import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final double? borderRadius;
  final VoidCallback? onRemove;
  final Color? backgroundColor;
  final Widget child;

  const CustomChip({
    super.key,
    required this.child,
    this.onRemove,
    this.backgroundColor,
    this.borderRadius = 24
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, onRemove == null ? 20 : 12, 10),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white.withOpacity(.05),
        borderRadius: BorderRadius.circular(borderRadius!)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          Visibility(
            visible: onRemove != null,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                onTap: onRemove,
                child: const Icon(
                  Icons.close,
                  size: 16,
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
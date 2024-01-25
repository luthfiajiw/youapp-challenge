import 'package:flutter/material.dart';

SnackBar errorSnackbar(BuildContext context, {String? message}) {
  return SnackBarToast(
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.info_outline_rounded,
            color: Colors.white,
          ),
        ),
        Flexible(
          child: Text(
            message ?? "",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    )
  );
}

class SnackBarToast extends SnackBar {
  
  SnackBarToast({
    super.key, 
    required super.content
  }) : super(
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8)
    ),
    margin: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16
    )
  );
}
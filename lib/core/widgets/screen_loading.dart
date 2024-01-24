import 'package:flutter/material.dart';

showScreenLoading(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const Dialog(
        shape: CircleBorder(),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: Center(
          child: SizedBox(
            height: 35,
            width: 35,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      );
    },
  );
}
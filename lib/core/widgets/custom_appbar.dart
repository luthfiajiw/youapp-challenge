import 'package:flutter/material.dart';

AppBar customAppbar({
  VoidCallback? onBack
}) {
  return AppBar(
    leadingWidth: 100,
    automaticallyImplyLeading: false,
    leading: onBack == null ? null : InkWell(
      onTap: onBack,
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 4),
            child: Icon(
              Icons.arrow_back_ios_new_rounded
            ),
          ),
          Text(
            "Back",
            style: TextStyle(
              fontSize: 16
            ),
          )
        ],
      ),
    ),
  );
}
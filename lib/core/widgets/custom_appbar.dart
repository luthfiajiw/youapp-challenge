import 'package:flutter/material.dart';

AppBar customAppbar({
  VoidCallback? onBack,
  Widget? title,
  List<Widget>? actions
}) {
  return AppBar(
    leadingWidth: 109,
    automaticallyImplyLeading: false,
    leading: onBack == null ? null : InkWell(
      onTap: onBack,
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 4),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
            ),
          ),
          Text(
            "Back",
            style: TextStyle(
              fontSize: 14
            ),
          )
        ],
      ),
    ),
    title: title,
    centerTitle: true,
    actions: actions,
  );
}
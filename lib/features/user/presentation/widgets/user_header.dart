import 'package:flutter/material.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/edit_button.dart';

class UserHeader extends StatefulWidget {
  const UserHeader({super.key});

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.fromLTRB(20, 8, 8, 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.15),
        borderRadius: BorderRadius.circular(16)
      ),
      child: const Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: EditButton()
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "@acuy,",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700
              ),
            )
          ),
        ],
      ),
    );
  }
}
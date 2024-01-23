import 'package:flutter/material.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/edit_button.dart';

class UserInterest extends StatefulWidget {
  const UserInterest({super.key});

  @override
  State<UserInterest> createState() => _UserInterestState();
}

class _UserInterestState extends State<UserInterest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 8, 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.05)
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Interest",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                ),
              ),
              EditButton()
            ],
          ),
          SizedBox(height: 22,),
          Text(
            "Add in your interest to find a better match",
            style: TextStyle(color: Colors.white60),
          )
        ],
      ),
    );
  }
}
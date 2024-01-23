import 'package:flutter/material.dart';
import 'package:youapp_challenge/core/widgets/custom_appbar.dart';
import 'package:youapp_challenge/core/widgets/gradient_icon.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/user_about.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/user_header.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/user_interest.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: customAppbar(
        title: const Text(
          "@acuy",
          style: TextStyle(
            fontSize: 14
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const GradientIcon(
              icon: Icon(
                Icons.logout_rounded,
              ),
            )
          )
        ]
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(8),
            child: UserHeader(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: UserAbout()
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: UserInterest(),
          ),
        ],
      ),
    );
  }
}
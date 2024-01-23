import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/edit_button.dart';

class UserHeader extends StatefulWidget {
  const UserHeader({super.key});

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Container(
          height: 200,
          padding: const EdgeInsets.fromLTRB(20, 8, 14, 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.15),
            borderRadius: BorderRadius.circular(16)
          ),
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: EditButton()
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Visibility(
                  visible: state.getUserStatus == GetUserStatus.done,
                  child: Text(
                    "@${state.username},",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                )
              ),
            ],
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/core/widgets/chip.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';

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
              Align(
                alignment: Alignment.bottomLeft,
                child: Visibility(
                  visible: state.username != null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "@${state.username}, ${state.age}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Visibility(
                            visible: state.horoscope!.isNotEmpty,
                            child: CustomChip(child: Text(state.horoscope!)),
                          ),
                          Visibility(
                            visible: state.zodiac!.isNotEmpty,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: CustomChip(child: Text(state.zodiac!)),
                            ),
                          ),
                        ],
                      )
                    ],
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
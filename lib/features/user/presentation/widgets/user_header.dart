import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/config/theme/palette.dart';
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
    const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.125),
            borderRadius: BorderRadius.circular(16),
            image: state.image == null 
            ? null 
            : DecorationImage(
              image: kIsWeb ? NetworkImage(state.image!.path) as ImageProvider : FileImage(File(state.image!.path)),
              fit: BoxFit.cover
            )
          ),
          child: Stack(
            children: [
              if (state.image != null) Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(.9)
                    ]
                  )
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Visibility(
                  visible: state.username!.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "@${state.username}, ${state.age}",
                          key: const Key("username"),
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
                              child: CustomChip(
                                key: const Key("horo-chip"),
                                backgroundColor: Palette.secondaryDark,
                                child: Text(
                                  state.horoscope!,
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: state.zodiac!.isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: CustomChip(
                                  key: const Key("zod-chip"),
                                  backgroundColor: Palette.secondaryDark,
                                  child: Text(
                                    state.zodiac!,
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  )
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
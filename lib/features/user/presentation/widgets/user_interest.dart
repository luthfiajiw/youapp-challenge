import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/config/routes/route_pahts.dart';
import 'package:youapp_challenge/core/widgets/chip.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/edit_button.dart';

class UserInterest extends StatefulWidget {
  const UserInterest({super.key});

  @override
  State<UserInterest> createState() => _UserInterestState();
}

class _UserInterestState extends State<UserInterest> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 8, 8, 20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withOpacity(0.05)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Interest",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  EditButton(
                    key: const Key("btn-edit-interest"),
                    onTap: () => Navigator.pushNamed(context, RoutePaths.interests),
                  )
                ],
              ),
              const SizedBox(height: 16,),
              Visibility(
                visible: state.interests!.isNotEmpty,
                replacement: const Text(
                  "Add in your interest to find a better match",
                  key: Key("initial-interest"),
                  style: TextStyle(color: Colors.white60),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(state.interests!.length, (index) {
                    String interest = state.interests![index];

                    return CustomChip(
                      key: Key(interest),
                      child: Text(
                        interest,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
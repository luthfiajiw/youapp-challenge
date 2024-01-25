import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/config/theme/palette.dart';
import 'package:youapp_challenge/core/widgets/chip.dart';
import 'package:youapp_challenge/core/widgets/custom_appbar.dart';
import 'package:youapp_challenge/core/widgets/gradient_background.dart';
import 'package:youapp_challenge/core/widgets/gradient_text.dart';
import 'package:youapp_challenge/core/widgets/screen_loading.dart';
import 'package:youapp_challenge/features/user/domain/entities/form_user_entity.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';

class InterestsView extends StatefulWidget {
  const InterestsView({super.key});

  @override
  State<InterestsView> createState() => _InterestsViewState();
}

class _InterestsViewState extends State<InterestsView> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: BlocConsumer<UserCubit, UserState>(
        listenWhen: (prev, cur) => prev.putUserStatus != cur.putUserStatus,
        listener: (context, state) {
          if (state.putUserStatus == PutUserStatus.done) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: customAppbar(
                onBack: () => Navigator.pop(context),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: InkWell(
                      onTap: () {
                        final form = FormUserEntity(
                          name: state.name!,
                          birthday: state.birthday!,
                          height: state.height!,
                          weight: state.weight!,
                          interests: state.interests!,
                        );

                        FocusScope.of(context).unfocus();
                        showScreenLoading(context);
                        context.read<UserCubit>().onPutUser(form);
                      },
                      child: ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Palette.blue3,
                            Palette.blue2,
                          ]
                        ).createShader(bounds);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Save"),
                      )
                    ),
                    ),
                  )
                ]
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GradientText(
                      text: Text(
                        "Tell everyone about yourself",
                      ),
                    ),
                    const SizedBox(height: 8,),
                    const Text(
                      "What interest you?",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20
                      ),
                    ),
                    const SizedBox(height: 24,),
                    GestureDetector(
                      onTap: () => focusNode.requestFocus(),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.05),
                          borderRadius: BorderRadius.circular(9)
                        ),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          runAlignment: WrapAlignment.center,
                          children: [
                            ...List.generate(state.interests!.length, (index) {
                              String interest = state.interests![index];
                              
                              return CustomChip(
                                borderRadius: 9,
                                onRemove: () {
                                  final updated = state.interests!.where((element) => element != interest).toList();
                                  context.read<UserCubit>().onChangeInterest(updated);
                                },
                                child: Text(
                                  interest,
                                ),
                              );
                            }).toList(),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * .3
                              ),
                              child: TextFormField(
                                focusNode: focusNode,
                                controller: textController,
                                decoration: const InputDecoration(
                                  fillColor: Colors.transparent,
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 6)
                                ),
                                onFieldSubmitted: (value) {
                                  context.read<UserCubit>().onChangeInterest([...state.interests!, value]);
                                  textController.clear();
                                  focusNode.requestFocus();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
        },
      ),
    );
  }
}
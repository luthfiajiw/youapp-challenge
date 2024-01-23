
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/config/theme/palette.dart';
import 'package:youapp_challenge/core/resources/form_validator_mixin.dart';
import 'package:youapp_challenge/core/widgets/custom_appbar.dart';
import 'package:youapp_challenge/core/widgets/gradient_background.dart';
import 'package:youapp_challenge/core/widgets/gradient_button.dart';
import 'package:youapp_challenge/core/widgets/gradient_icon.dart';
import 'package:youapp_challenge/core/widgets/gradient_text.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_state.dart';

class RegisterView extends StatelessWidget with FormValidatorMixin {
  final AuthBloc authBloc;
  final GlobalKey<FormState> formKey;

  RegisterView({super.key, required this.authBloc, required this.formKey});


  void _onValidateForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(RegisterSubmitted());
    } else {
      context.read<AuthBloc>().add(ConfirmPassAutovalidateChanged(autovalidateMode: AutovalidateMode.always));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: customAppbar(
          onBack: () => Navigator.pop(context),
        ),
        body: BlocProvider(
          create: (context) => authBloc,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.authStatus == AuthSubmissionStatus.done) {
                Navigator.pop(context);
              }
              if (state.authStatus == AuthSubmissionStatus.error) {
                // Handle Snackbar Error Here
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 24.0, left: 16),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          key: const Key('email'),
                          validator: isEmailValid,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => context.read<AuthBloc>().add(AuthEmailChanged(email: value)),
                          decoration: const InputDecoration(
                            hintText: "Enter Email",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          key: const Key('username'),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => context.read<AuthBloc>().add(AuthUsernameChanged(username: value)),
                          decoration: const InputDecoration(
                            hintText: "Crate Username",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          key: const Key("create-password"),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !state.showPassword!,
                          obscuringCharacter: "*",
                          onChanged: (value) => context.read<AuthBloc>().add(AuthPasswordChanged(password: value)),
                          decoration: InputDecoration(
                            hintText: "Create Password",
                            suffixIcon: IconButton(
                              onPressed: () => context.read<AuthBloc>().add(ToggleShowPassword()),
                                icon: Visibility(
                                visible: state.showPassword!,
                                replacement: const GradientIcon(
                                  icon: Icon(Icons.visibility_off_outlined),
                                ),
                                child: const GradientIcon(
                                  icon: Icon(Icons.visibility_outlined),
                                ),
                              )
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: TextFormField(
                          key: const Key("confirm-password"),
                          keyboardType: TextInputType.visiblePassword,
                          autovalidateMode: state.confirmPasswordAutovalidate,
                          obscureText: !state.showConfirmPassword!,
                          obscuringCharacter: "*",
                          onChanged: (value) => context.read<AuthBloc>().add(AuthConfirmPasswordChanged(password: value)),
                          validator: (value) => validateConfirmPassword(value, state.password),
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            suffixIcon: IconButton(
                              onPressed: () => context.read<AuthBloc>().add(ToggleShowConfirmPassword()),
                                icon: Visibility(
                                visible: state.showConfirmPassword!,
                                replacement: const GradientIcon(
                                  icon: Icon(Icons.visibility_off_outlined),
                                ),
                                child: const GradientIcon(
                                  icon: Icon(Icons.visibility_outlined),
                                ),
                              )
                            )
                          ),
                        ),
                      ),
                      GradientButton(
                        key: const Key("btn-register"),
                        isLoading: state.authStatus == AuthSubmissionStatus.submitting,
                        disabled: !isAllFieldFilled([state.email, state.username, state.password, state.confirmPassword]) || (state.password?.length ?? 0) < 8,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          _onValidateForm(context);
                        },
                        padding: const EdgeInsets.all(14),
                        child: const Text(
                          "Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                          ),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Have an account?"),
                            const SizedBox(width: 4,),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              borderRadius: BorderRadius.circular(4),
                              child: GradientText(
                                text: Text(
                                  "Login here",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decorationColor: Palette.golden3.withOpacity(.5)
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
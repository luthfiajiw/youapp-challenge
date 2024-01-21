import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/config/routes/route_pahts.dart';
import 'package:youapp_challenge/config/theme/palette.dart';
import 'package:youapp_challenge/core/widgets/gradient_background.dart';
import 'package:youapp_challenge/core/widgets/gradient_button.dart';
import 'package:youapp_challenge/core/widgets/gradient_icon.dart';
import 'package:youapp_challenge/core/widgets/gradient_text.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_state.dart';

class LoginView extends StatelessWidget {
  final AuthBloc authBloc;

  const LoginView({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => authBloc,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.authStatus == AuthSubmissionStatus.done) {
                Navigator.pushReplacementNamed(context, RoutePaths.user);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 24.0, left: 16),
                        child: Text(
                          "Login",
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
                        onChanged: (value) => context.read<AuthBloc>().add(AuthEmailChanged(email: value)),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Enter Email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: TextFormField(
                        key: const Key("password"),
                        onChanged: (value) => context
                          .read<AuthBloc>()
                          .add(AuthPasswordChanged(password: value)),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !state.showPassword!,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          suffixIcon: IconButton(
                            key: const Key('btn-visibility'),
                            onPressed: () => context
                              .read<AuthBloc>()
                              .add(ToggleShowPassword()
                            ),
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
                    GradientButton(
                      key: const Key("btn-login"),
                      disabled: state.email == null || state.password == null || (state.password?.length ?? 0) < 8,
                      isLoading: state.authStatus == AuthSubmissionStatus.submitting,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.read<AuthBloc>().add(LoginSubmitted());
                      },
                      padding: const EdgeInsets.all(14),
                      child: const Text(
                        "Login",
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
                          const Text("No account?"),
                          const SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, RoutePaths.register),
                            borderRadius: BorderRadius.circular(4),
                            child: GradientText(
                              text: Text(
                                "Register here",
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
              );
            },
          ),
        ),
      ),
    );
  }
}

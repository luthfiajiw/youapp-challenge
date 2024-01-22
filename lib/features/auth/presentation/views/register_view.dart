
import 'package:flutter/material.dart';
import 'package:youapp_challenge/config/theme/palette.dart';
import 'package:youapp_challenge/core/resources/form_validator.dart';
import 'package:youapp_challenge/core/widgets/custom_appbar.dart';
import 'package:youapp_challenge/core/widgets/gradient_background.dart';
import 'package:youapp_challenge/core/widgets/gradient_button.dart';
import 'package:youapp_challenge/core/widgets/gradient_icon.dart';
import 'package:youapp_challenge/core/widgets/gradient_text.dart';

class RegisterView extends StatelessWidget with FormValidator {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: customAppbar(
          onBack: () => Navigator.pop(context),
        ),
        body: Padding(
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
                  keyboardType: TextInputType.emailAddress,
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
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: "Create Password",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const GradientIcon(
                        icon: Icon(
                          Icons.visibility_off_outlined
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
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const GradientIcon(
                        icon: Icon(
                          Icons.visibility_off_outlined
                        ),
                      )
                    )
                  ),
                ),
              ),
              GradientButton(
                key: const Key("btn-register"),
                onTap: () {},
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
      ),
    );
  }
}
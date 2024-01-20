import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_challenge/features/auth/presentation/views/login_view.dart';

void main() {
  group("Login View", () {
    testWidgets("has 2 textfield and 1 button", (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginView(),
        )
      );

      // Finders
      final titleFinder = find.text('Login');
      final emailTextfieldFinder = find.byKey(const Key('email'));
      final passwordTextfieldFinder = find.byKey(const Key('password'));
      final btnLoginFinder = find.byKey(const Key('btn-login'));

      expect(titleFinder, findsNWidgets(2));
      expect(emailTextfieldFinder, findsOneWidget);
      expect(passwordTextfieldFinder, findsOneWidget);
      expect(btnLoginFinder, findsOneWidget);
    });
  });
}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_challenge/features/auth/presentation/views/register_view.dart';

void main() {
  group("Login View", () {
    testWidgets("has 4 textfield and 1 button", (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterView(),
        )
      );

      // Finders
      final titleFinder = find.text('Register');
      final emailTextfieldFinder = find.byKey(const Key('email'));
      final usernameTextfieldFinder = find.byKey(const Key('username'));
      final createPasswordTextfieldFinder = find.byKey(const Key('create-password'));
      final confirmPasswordTextfieldFinder = find.byKey(const Key('confirm-password'));
      final btnRegisterFinder = find.byKey(const Key('btn-register'));

      expect(titleFinder, findsNWidgets(2));
      expect(emailTextfieldFinder, findsOneWidget);
      expect(usernameTextfieldFinder, findsOneWidget);
      expect(createPasswordTextfieldFinder, findsOneWidget);
      expect(confirmPasswordTextfieldFinder, findsOneWidget);
      expect(btnRegisterFinder, findsOneWidget);
    });
  });
}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_challenge/core/widgets/chip.dart';
import 'package:youapp_challenge/features/auth/presentation/views/login_view.dart';
import 'package:youapp_challenge/features/user/presentation/views/interests_view.dart';
import 'package:youapp_challenge/features/user/presentation/views/user_view.dart';
import 'package:youapp_challenge/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  navigateToInterestsView(WidgetTester tester) async {
    // navigate to interests view
    await tester.ensureVisible(find.byKey(const Key("btn-edit-interest")));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("btn-edit-interest")));
    await Future.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // enter interests view 
    expectLater(find.byType(InterestsView), findsOneWidget);
  }

  testWidgets("E2E Test", (tester) async {
    app.main();

    await tester.pumpAndSettle();

    // Splash View
    // finders
    final logoFinder = find.byKey(const Key('logo'));
    expect(logoFinder, findsOneWidget);

    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byType(LoginView), findsOneWidget);

    // fill in form with wrong email
    await tester.enterText(find.byKey(const Key('email')), "abc123@mail.com");
    await Future.delayed(const Duration(seconds: 1));
    await tester.enterText(find.byKey(const Key('password')), "12345678");
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));

    // submit form
    final btnLoginFinder = find.byKey(const Key('btn-login'));
    expect(btnLoginFinder, findsOneWidget);
    await tester.tap(btnLoginFinder);
    await tester.pump();
    await Future.delayed(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // show error snackbar
    expectLater(find.byType(SnackBar), findsOneWidget);

    // fill again with the correct email
    await tester.enterText(find.byKey(const Key('email')), "acuy@mail.com");
    await tester.pumpAndSettle();
    await tester.tap(btnLoginFinder);
    await tester.pump();
    await Future.delayed(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // enter user view
    expectLater(find.byType(UserView), findsOneWidget);

    // open about section
    await tester.tap(find.byKey(const Key("btn-edit-about")));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));

    // fill in about section
    // fill in name
    await tester.enterText(find.byType(TextFormField).at(0), "Acuy Siahaan");
    await Future.delayed(const Duration(seconds: 1));
    // fill in birthday
    await tester.tap(find.byType(TextFormField).at(1));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(find.text('15').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    // fill in height
    await tester.enterText(find.byType(TextFormField).at(4), "167");
    await Future.delayed(const Duration(seconds: 1));
    // fill in weight
    await tester.enterText(find.byType(TextFormField).at(5), "60");
    await Future.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    
    // submit about section
    await tester.ensureVisible(find.byKey(const Key("btn-save-about")));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(find.byKey(const Key("btn-save-about")));
    await tester.pump();

    // show screen loading
    expect(find.byType(Dialog), findsOneWidget);

    await tester.pumpAndSettle();

    // expect 3 custom chip, 1 custom chip is for interest
    expect(find.byType(CustomChip), findsNWidgets(3));

    // navigate to interests view
    await navigateToInterestsView(tester);

    // fill in music to interest
    final interestTextfield = find.byKey(const Key("tf-interest"));
    await tester.enterText(interestTextfield, "Music");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await Future.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // submit interests
    final btnSaveInterests = find.byKey(const Key("btn-save-interests"));

    await tester.tap(btnSaveInterests);
    await tester.pump();

    // show screen loading
    expect(find.byType(Dialog), findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();

    // expect 4 custom chip, 2 custom chip is for interest
    expectLater(find.byType(CustomChip), findsNWidgets(4));

    // navigate to interests view
    await navigateToInterestsView(tester);

    // remove 1 interest
    await tester.tap(find.byType(Icon).at(1));
    await tester.pumpAndSettle();

    // submit interests
    await tester.tap(btnSaveInterests);
    await tester.pump();

    // show screen loading
    expect(find.byType(Dialog), findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();

    // expect 3 custom chip, 1 custom chip is for interest
    expectLater(find.byType(CustomChip), findsNWidgets(3));
  });
}
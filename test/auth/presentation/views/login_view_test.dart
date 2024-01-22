import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_state.dart';
import 'package:youapp_challenge/features/auth/presentation/views/login_view.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockNavigator mockNavigator;
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockNavigator = MockNavigator();
    mockAuthBloc = MockAuthBloc();

    // stub naviagtor
    when(mockNavigator.canPop).thenReturn(true);
    when(() => mockNavigator.pushReplacementNamed(any())).thenAnswer((_) async => null);
  });

  Widget loginView() {
    return MaterialApp(
      home: MockNavigatorProvider(
        navigator: mockNavigator,
        child: LoginView(authBloc: mockAuthBloc,)
      ),
    );
  }
  
  group("Login View", () {
    // Finders
    final btnLoginFinder = find.byKey(const Key('btn-login'));
    final titleFinder = find.text('Login');
    final emailTextfieldFinder = find.byKey(const Key('email'));
    final passwordTextfieldFinder = find.byKey(const Key('password'));
    final visibilityBtnFinder = find.byKey(const Key('btn-visibility'));
    final visibilityIconFinder = find.byIcon(Icons.visibility_outlined);
    final visibilityOffIconFinder = find.byIcon(Icons.visibility_off_outlined);

    testWidgets("has 2 textfield and 1 button", (tester) async {
      // arrange
      when(() => mockAuthBloc.state,).thenReturn(const AuthState());
      
      await tester.pumpWidget(loginView());

      expect(titleFinder, findsNWidgets(2));
      expect(emailTextfieldFinder, findsOneWidget);
      expect(passwordTextfieldFinder, findsOneWidget);
      expect(btnLoginFinder, findsOneWidget);
    });

    testWidgets("icon visibility on password should change accroding to showPassword state", (tester) async {
      // arrange
      when(() => mockAuthBloc.state,).thenReturn(const AuthState());
      when(() => mockAuthBloc.add(ToggleShowPassword())).thenAnswer((_) async {});
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([const AuthState(), const AuthState(showPassword: true)])
      );

      await tester.pumpWidget(loginView());

      expect(visibilityBtnFinder, findsOneWidget);
      // visibility off
      expect(visibilityOffIconFinder, findsOneWidget);
      expect(visibilityIconFinder, findsNothing);

      // act
      await tester.tap(visibilityBtnFinder);
      await tester.pumpAndSettle();

      verify(() => mockAuthBloc.add(ToggleShowPassword())).called(1);

      // visibility on
      expect(visibilityOffIconFinder, findsNothing);
      expect(visibilityIconFinder, findsOneWidget);
    });

    testWidgets("when AuthSubmissionStatus is done should navigate to UserView", (tester) async {
      // arrange
      when(() => mockAuthBloc.state,).thenReturn(const AuthState(email: "email", password: "password"));
      when(() => mockAuthBloc.add(LoginSubmitted())).thenAnswer((_) async {});
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([
          const AuthState(email: "email", password: "password"),
          const AuthState(authStatus: AuthSubmissionStatus.done)
        ])
      );

      await tester.pumpWidget(loginView());

      // act
      await tester.tap(btnLoginFinder);

      // verify event is called
      verify(() => mockAuthBloc.add(LoginSubmitted())).called(1);

      // verify navigator is called
      verify(() => mockNavigator.pushReplacementNamed('/user')).called(1);
    });
  });
}
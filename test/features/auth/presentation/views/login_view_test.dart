import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_state.dart';
import 'package:youapp_challenge/features/auth/presentation/views/login_view.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<AuthBloc>(
      create: (context) => mockAuthBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }
  
  group("Login View", () {
    testWidgets("has 2 textfield and 1 button", (tester) async {
      // arrange
      when(() => mockAuthBloc.state,).thenReturn(const AuthState());
      
      await tester.pumpWidget(makeTestableWidget(const LoginView()));

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

    testWidgets("icon visibility on password should change accroding to showPassword state", (tester) async {
      // arrange
      when(() => mockAuthBloc.state,).thenReturn(const AuthState());
      when(() => mockAuthBloc.add(ToggleShowPassword())).thenAnswer((_) async {});
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([const AuthState(), const AuthState(showPassword: true)])
      );

      await tester.pumpWidget(makeTestableWidget(const LoginView()));
      
      // finders
      final visibilityBtnFinder = find.byKey(const Key('btn-visibility'));
      final visibilityIconFinder = find.byIcon(Icons.visibility_outlined);
      final visibilityOffIconFinder = find.byIcon(Icons.visibility_off_outlined);

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
  });
}
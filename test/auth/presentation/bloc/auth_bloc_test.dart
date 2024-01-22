import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/core/services/shared_prefs_service.dart';
import 'package:youapp_challenge/features/auth/domain/entities/auth_response_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';
import 'package:youapp_challenge/features/auth/domain/usecases/post_login_usecase.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_state.dart';

class MockPostLogin extends Mock implements PostLogin {}

void main() {
  late MockPostLogin mockPostLogin;
  late SharedPrefsService sharedPrefs;
  late AuthBloc authBloc;

  setUp(() async {
    // Mock Shared Prefs
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    sharedPrefs = SharedPrefsService(prefs: prefs);

    mockPostLogin = MockPostLogin();
    authBloc = AuthBloc(mockPostLogin, sharedPrefs);
  });

  group('Auth Bloc', () {
    test('initial state', () {
      expect(authBloc.state.registerFormKey, isA<GlobalKey<FormState>>());
      expect(authBloc.state.email, isNull);
      expect(authBloc.state.username, isNull);
      expect(authBloc.state.password, isNull);
      expect(authBloc.state.confirmPassword, isNull);
      expect(authBloc.state.showPassword, false);
      expect(authBloc.state.showConfirmPassword, false);
      expect(authBloc.state.authStatus, AuthSubmissionStatus.idle);
      expect(authBloc.state.registerAutovalidate, AutovalidateMode.disabled);
    });

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthState.email] when AuthEmailChanged event is added.',
      build: () => authBloc,
      act: (bloc) => bloc.add(AuthEmailChanged(email: "abc@mail.com")),
      expect: () => const <AuthState>[
        AuthState(email: "abc@mail.com")
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthState.username] when AuthUsernameChanged event is added.',
      build: () => authBloc,
      act: (bloc) => bloc.add(AuthUsernameChanged(username: "abc")),
      expect: () => const <AuthState>[
        AuthState(username: "abc")
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthState.password] when AuthPasswordChanged event is added.',
      build: () => authBloc,
      act: (bloc) => bloc.add(AuthPasswordChanged(password: "1234")),
      expect: () => const <AuthState>[
        AuthState(password: "1234")
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthState.confirmPassword] when AuthConfirmPasswordChanged event is added.',
      build: () => authBloc,
      act: (bloc) => bloc.add(AuthConfirmPasswordChanged(password: "1234")),
      expect: () => const <AuthState>[
        AuthState(confirmPassword: "1234")
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthState.showPassword] when ToggleShowPassword event is added.',
      build: () => authBloc,
      act: (bloc) => bloc.add(ToggleShowPassword()),
      expect: () => const <AuthState>[
        AuthState(showPassword: true)
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthState.confirmShowPassword] when ToggleShowConfirmPassword event is added.',
      build: () => authBloc,
      act: (bloc) => bloc.add(ToggleShowConfirmPassword()),
      expect: () => const <AuthState>[
        AuthState(showConfirmPassword: true)
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'when LoginSubmitted event is added and succeed, store accessToken into shared prefs',
      build: () => authBloc,
      act: (bloc) {
        when(() => mockPostLogin(params: const LoginEntity(email: "email", password: "password")),)
          .thenAnswer((_) async => DataSuccess(const AuthResponseEntity(message: "success", accessToken: "token")));
        
        bloc.add(AuthEmailChanged(email: "email"));
        bloc.add(AuthPasswordChanged(password: "password"));
        bloc.add(LoginSubmitted());
      },
      expect: () {
        expect(sharedPrefs.getAccessToken(), "token");

        return const <AuthState>[
          AuthState(
            email: "email",
            password: null,
            showPassword: false,
            authStatus: AuthSubmissionStatus.idle
          ),
          AuthState(
            email: "email",
            password: "password",
            showPassword: false,
            authStatus: AuthSubmissionStatus.idle
          ),
          AuthState(
            email: "email",
            password: "password",
            showPassword: false,
            authStatus: AuthSubmissionStatus.submitting
          ),
          AuthState(
            email: "email",
            password: "password",
            authStatus: AuthSubmissionStatus.done
          )
        ];
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthState] when ResetForm event is added.',
      build: () => authBloc,
      act: (bloc) => bloc.add(ResetForm()),
      expect: () => const <AuthState>[
        AuthState()
      ],
    );
  });
}
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_challenge/features/auth/domain/usecases/post_login_usecase.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_state.dart';

class MockPostLogin extends Mock implements PostLogin {}

void main() {
  late MockPostLogin mockPostLogin;
  late AuthBloc authBloc;

  setUp(() {
    mockPostLogin = MockPostLogin();
    authBloc = AuthBloc(mockPostLogin);
  });

  group('Auth Bloc', () {
    test('initial state should be empty', () {
      expect(authBloc.state.email, isNull);
      expect(authBloc.state.password, isNull);
      expect(authBloc.state.showPassword, false);
      expect(authBloc.state.authStatus, AuthSubmissionStatus.idle);
    });

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthState] when AuthEmailChanged event is added.',
      build: () => authBloc,
      act: (bloc) => bloc.add(AuthEmailChanged(email: "abc@mail.com")),
      expect: () => const <AuthState>[
        AuthState(email: "abc@mail.com")
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthState] when AuthPasswordChanged event is added.',
      build: () => authBloc,
      act: (bloc) => bloc.add(AuthPasswordChanged(password: "1234")),
      expect: () => const <AuthState>[
        AuthState(password: "1234")
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthState] when ToggleShowPassword event is added.',
      build: () => authBloc,
      act: (bloc) => bloc.add(ToggleShowPassword()),
      expect: () => const <AuthState>[
        AuthState(showPassword: true)
      ],
    );
  });
}
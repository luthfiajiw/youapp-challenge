import 'package:equatable/equatable.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/states/auth_submission_status.dart';

class AuthState extends Equatable{
  final String? email;
  final String? password;
  final bool? showPassword;
  final AuthSubmissionStatus? authStatus;

  const AuthState({
    this.email,
    this.password,
    this.showPassword = false,
    this.authStatus = const InitialAuthStatus()
  });

  AuthState copyWith({
    String? email,
    String? password,
    bool? showPassword,
    AuthSubmissionStatus? authStatus
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      authStatus: authStatus ?? this.authStatus
    );
  }
  
  @override
  List<Object?> get props => [
    email, password, authStatus
  ];
}
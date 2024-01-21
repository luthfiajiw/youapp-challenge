import 'package:equatable/equatable.dart';

enum AuthSubmissionStatus {
  idle, submitting, done, error
}

class AuthState extends Equatable{
  final String? email;
  final String? password;
  final bool? showPassword;
  final AuthSubmissionStatus? authStatus;

  const AuthState({
    this.email,
    this.password,
    this.showPassword = false,
    this.authStatus = AuthSubmissionStatus.idle
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
    email, password, showPassword, authStatus
  ];
}
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AuthSubmissionStatus {
  idle, submitting, done, error
}

class AuthState extends Equatable{
  final String? email;
  final String? username;
  final String? password;
  final String? confirmPassword;
  final bool? showPassword;
  final bool? showConfirmPassword;
  final AuthSubmissionStatus? authStatus;
  final AutovalidateMode? confirmPasswordAutovalidate;

  const AuthState({
    this.email,
    this.username,
    this.password,
    this.confirmPassword,
    this.showPassword = false,
    this.showConfirmPassword = false,
    this.authStatus = AuthSubmissionStatus.idle,
    this.confirmPasswordAutovalidate = AutovalidateMode.disabled
  });

  AuthState copyWith({
    String? email,
    String? username,
    String? password,
    String? confirmPassword,
    bool? showPassword,
    bool? showConfirmPassword,
    AuthSubmissionStatus? authStatus,
    AutovalidateMode? confirmPasswordAutovalidate,
  }) {
    return AuthState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      authStatus: authStatus ?? this.authStatus,
      confirmPasswordAutovalidate: confirmPasswordAutovalidate ?? this.confirmPasswordAutovalidate
    );
  }
  
  @override
  List<Object?> get props => [
    email, username, password, confirmPassword, showPassword,
    showConfirmPassword, authStatus, confirmPasswordAutovalidate
  ];
}
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AuthSubmissionStatus {
  idle, submitting, done, error
}

class AuthState extends Equatable{
  final GlobalKey<FormState>? registerFormKey;
  final String? email;
  final String? username;
  final String? password;
  final String? confirmPassword;
  final bool? showPassword;
  final bool? showConfirmPassword;
  final AuthSubmissionStatus? authStatus;
  final AutovalidateMode? registerAutovalidate;

  const AuthState({
    this.registerFormKey,
    this.email,
    this.username,
    this.password,
    this.confirmPassword,
    this.showPassword = false,
    this.showConfirmPassword = false,
    this.authStatus = AuthSubmissionStatus.idle,
    this.registerAutovalidate = AutovalidateMode.disabled
  });

  AuthState copyWith({
    GlobalKey<FormState>? registerFormKey,
    String? email,
    String? username,
    String? password,
    String? confirmPassword,
    bool? showPassword,
    bool? showConfirmPassword,
    AuthSubmissionStatus? authStatus,
    AutovalidateMode? registerAutovalidate,
  }) {
    return AuthState(
      registerFormKey: registerFormKey ?? this.registerFormKey,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      authStatus: authStatus ?? this.authStatus,
      registerAutovalidate: registerAutovalidate ?? this.registerAutovalidate
    );
  }
  
  @override
  List<Object?> get props => [
    email, username, password, confirmPassword, showPassword,
    showConfirmPassword, authStatus, registerAutovalidate
  ];
}
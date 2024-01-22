import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {}

class AuthEmailChanged extends AuthEvent {
  final String email;

  AuthEmailChanged({required this.email});
  
  @override
  List<Object?> get props => [email];
}

class AuthUsernameChanged extends AuthEvent {
  final String username;

  AuthUsernameChanged({required this.username});
  
  @override
  List<Object?> get props => [username];
}

class AuthPasswordChanged extends AuthEvent {
  final String password;

  AuthPasswordChanged({required this.password});
  
  @override
  List<Object?> get props => [password];
}

class AuthConfirmPasswordChanged extends AuthEvent {
  final String password;

  AuthConfirmPasswordChanged({required this.password});
  
  @override
  List<Object?> get props => [password];
}

class AuthRegisterAutovalidateChanged extends AuthEvent {
  final AutovalidateMode autovalidateMode;

  AuthRegisterAutovalidateChanged({required this.autovalidateMode});
  
  @override
  List<Object?> get props => [autovalidateMode];
}

class ToggleShowPassword extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class ToggleShowConfirmPassword extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class ResetForm extends AuthEvent {
  @override
  List<Object?> get props => [];
}
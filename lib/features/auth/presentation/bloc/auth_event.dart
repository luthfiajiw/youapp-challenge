import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class AuthEmailChanged extends AuthEvent {
  final String email;

  AuthEmailChanged({required this.email});
  
  @override
  List<Object?> get props => [email];
}

class AuthPasswordChanged extends AuthEvent {
  final String password;

  AuthPasswordChanged({required this.password});
  
  @override
  List<Object?> get props => [password];
}

class ToggleShowPassword extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends AuthEvent {
  @override
  List<Object?> get props => [];
}
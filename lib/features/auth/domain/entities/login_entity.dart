import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String email;
  final String? username;
  final String password;

  const LoginEntity({required this.email, this.username = "", required this.password});
  
  @override
  List<Object?> get props => [
    email, username, password
  ];
}
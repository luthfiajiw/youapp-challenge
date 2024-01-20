import 'package:equatable/equatable.dart';

class AuthResponseEntity extends Equatable {
  final String message;
  final String? accessToken;

  const AuthResponseEntity({required this.message, this.accessToken});
  
  @override
  List<Object?> get props => [
    message, accessToken
  ];
}
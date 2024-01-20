import 'package:youapp_challenge/features/auth/domain/entities/auth_response_entity.dart';

class AuthResponseModel extends AuthResponseEntity {
  const AuthResponseModel({
    required String message,
    String? accessToken
  }) : super(
    message: message,
    accessToken: accessToken
  );

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      message: json["message"],
      accessToken: json["access_token"]
    );
  }
}
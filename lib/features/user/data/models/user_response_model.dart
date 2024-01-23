import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';

class UserResponseModel extends UserResponseEntity {
  const UserResponseModel({
    String? message,
    UserEntity? data
  }) : super (
    message: message,
    data: data
  );

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      message: json["message"],
      data: UserEntity(
        email: json["data"]?["email"] ?? "",
        username: json["data"]?["username"] ?? "",
        name: json["data"]?["name"] ?? "",
        birthday: json["data"]?["birthday"] ?? "",
        horoscope: json["data"]?["horoscope"] ?? "",
        zodiac: json["data"]?["zodiac"] ?? "",
        height: json["data"]?["height"] ?? 0,
        weight: json["data"]?["weight"] ?? 0,
        interests: json["data"]?["interests"] ?? const [],
      )
    );
  }
}
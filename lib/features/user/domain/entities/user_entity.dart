import 'package:equatable/equatable.dart';

class UserResponseEntity extends Equatable {
  final String? message;
  final UserEntity? data;

  const UserResponseEntity({
    this.message,
    this.data
  });
  
  @override
  List<Object?> get props => [message, data];
}

class UserEntity extends Equatable {
  final String? email;
  final String? username;
  final String? name;
  final String? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;
  final List? interests;

  const UserEntity({
    this.email = "--",
    this.username = "--",
    this.name = "--",
    this.birthday = "--",
    this.horoscope = "--",
    this.zodiac = "--",
    this.height = 0,
    this.weight = 0,
    this.interests = const []
  });
  
  @override
  List<Object?> get props => [
    email, username, name, birthday, horoscope, zodiac,
    height, weight, interests
  ];

}
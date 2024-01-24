import 'package:equatable/equatable.dart';

enum GetUserStatus {
  idle, loading, done, error
}

enum PutUserStatus {
  idle, submitting, done, error
}

class UserState extends Equatable {
  final GetUserStatus? getUserStatus;
  final PutUserStatus? putUserStatus;
  final String? email;
  final String? username;
  final String? name;
  final String? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? age;
  final int? height;
  final int? weight;
  final List? interests;

  const UserState({
    this.getUserStatus = GetUserStatus.idle,
    this.putUserStatus = PutUserStatus.idle,
    this.email = "",
    this.username = "",
    this.name = "--",
    this.birthday = "--",
    this.horoscope = "--",
    this.zodiac = "--",
    this.age = 0,
    this.height = 0,
    this.weight = 0,
    this.interests = const []
  });

  UserState copyWith({
    GetUserStatus? getUserStatus,
    PutUserStatus? putUserStatus,
    String? email,
    String? username,
    String? name,
    String? birthday,
    String? horoscope,
    String? zodiac,
    int? age,
    int? height,
    int? weight,
    List? interests,
  }) {
    return UserState(
      getUserStatus: getUserStatus ?? this.getUserStatus,
      putUserStatus: putUserStatus ?? this.putUserStatus,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      horoscope: horoscope ?? this.horoscope,
      zodiac: zodiac ?? this.zodiac,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      interests: interests ?? this.interests,
    );
  }
  
  @override
  List<Object?> get props => [
    getUserStatus, putUserStatus, email, username, name, birthday,
    horoscope, zodiac, age, height, weight, interests
  ];
}
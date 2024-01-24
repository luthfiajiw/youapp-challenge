import 'package:equatable/equatable.dart';

class FormUserEntity extends Equatable {
  final String name;
  final String birthday;
  final int height;
  final int weight;
  final List interests;

  const FormUserEntity({
    required this.name,
    required this.birthday,
    required this.height,
    required this.weight,
    required this.interests
  });
  
  @override
  List<Object?> get props => [
    name, birthday, height, weight, interests
  ];
}
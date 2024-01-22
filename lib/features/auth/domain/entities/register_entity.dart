import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';

class RegisterEntity extends LoginEntity {
  const RegisterEntity({
    required super.email,
    required super.username,
    required super.password
  });
}
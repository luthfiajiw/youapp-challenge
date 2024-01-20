import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/features/auth/domain/entities/auth_response_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';

abstract class AuthRepository {
  Future<DataState<AuthResponseEntity>> postLogin(LoginEntity loginEntity);
}
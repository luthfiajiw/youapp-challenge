import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/features/user/domain/entities/form_user_entity.dart';
import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<DataState<UserResponseEntity>> getUser();
  Future<DataState<UserResponseEntity>> putUser(FormUserEntity form);
}
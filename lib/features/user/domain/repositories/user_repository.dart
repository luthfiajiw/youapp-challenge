import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<DataState<UserEntity>> getUser();
}
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/core/resources/usecase.dart';
import 'package:youapp_challenge/features/user/domain/entities/form_user_entity.dart';
import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';
import 'package:youapp_challenge/features/user/domain/repositories/user_repository.dart';

class PutUser implements UseCase<DataState<UserResponseEntity>, FormUserEntity> {
  final UserRepository _userRepository;

  PutUser({required UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Future<DataState<UserResponseEntity>> call({FormUserEntity? params}) {
    return _userRepository.putUser(params!);
  }
}
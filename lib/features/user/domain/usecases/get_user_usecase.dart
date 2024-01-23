import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/core/resources/usecase.dart';
import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';
import 'package:youapp_challenge/features/user/domain/repositories/user_repository.dart';

class GetUser implements UseCase<DataState<UserEntity>, void> {
  final UserRepository _userRepository;

  GetUser({required UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Future<DataState<UserEntity>> call({void params}) {
    return _userRepository.getUser();
  }
}
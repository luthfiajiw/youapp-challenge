import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/core/resources/usecase.dart';
import 'package:youapp_challenge/features/auth/domain/entities/auth_response_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/register_entity.dart';
import 'package:youapp_challenge/features/auth/domain/repositories/auth_repository.dart';

class PostRegister extends UseCase<DataState<AuthResponseEntity>, RegisterEntity> {
  final AuthRepository _authRepository;

  PostRegister({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<DataState<AuthResponseEntity>> call({RegisterEntity? params}) {
    return _authRepository.postRegister(params!);
  }
}
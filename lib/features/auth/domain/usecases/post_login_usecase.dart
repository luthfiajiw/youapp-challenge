import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/core/resources/usecase.dart';
import 'package:youapp_challenge/features/auth/domain/entities/auth_response_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';
import 'package:youapp_challenge/features/auth/domain/repositories/auth_repository.dart';

class PostLogin implements UseCase<DataState<AuthResponseEntity>, LoginEntity> {
  final AuthRepository _authRepository;

  PostLogin({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<DataState<AuthResponseEntity>> call({LoginEntity? params}) {
    return _authRepository.postLogin(params!);
  }
}
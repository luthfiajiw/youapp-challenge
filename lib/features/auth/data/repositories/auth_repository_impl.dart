import 'package:dio/dio.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/features/auth/data/sources/remote_auth_source.dart';
import 'package:youapp_challenge/features/auth/domain/entities/auth_response_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/register_entity.dart';
import 'package:youapp_challenge/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final RemoteAuthSource _source;

  AuthRepositoryImpl({required RemoteAuthSource source}) : _source = source;

  @override
  Future<DataState<AuthResponseEntity>> postLogin(LoginEntity loginEntity) async {
    try {
      final response = await _source.postLogin(loginEntity);

      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<AuthResponseEntity>> postRegister(RegisterEntity registerEntity) async {
    try {
      final response = await _source.postRegister(registerEntity);

      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
  
}
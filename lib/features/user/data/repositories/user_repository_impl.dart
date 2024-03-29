import 'package:dio/dio.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/features/user/data/source/remote_user_source.dart';
import 'package:youapp_challenge/features/user/domain/entities/form_user_entity.dart';
import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';
import 'package:youapp_challenge/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final RemoteUserSource _userSource;

  UserRepositoryImpl({required RemoteUserSource source}) : _userSource = source;

  @override
  Future<DataState<UserResponseEntity>> getUser() async {
    try {
      final response = await _userSource.getUser();

      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserResponseEntity>> putUser(FormUserEntity form) async {
    try {
      final response = await _userSource.putUser(form);

      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
  
}
import 'package:dio/dio.dart';
import 'package:youapp_challenge/core/resources/response_mixin.dart';
import 'package:youapp_challenge/core/services/dio_service.dart';
import 'package:youapp_challenge/features/user/data/models/user_response_model.dart';

class RemoteUserSource with ResponseMixin{
  final DioService _dioService;

  RemoteUserSource({required DioService dioService}) : _dioService = dioService;

  Future<Response<UserResponseModel>> getUser() async {
    try {
      const path = '/getProfile';

      final result = await _dioService.dio.get(path);

      return response(result, UserResponseModel.fromJson(result.data));
    } catch (e) {
      rethrow;
    }
  }
}
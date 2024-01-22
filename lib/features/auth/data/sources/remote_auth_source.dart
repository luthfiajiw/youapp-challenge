import 'package:dio/dio.dart';
import 'package:youapp_challenge/core/resources/response_mixin.dart';
import 'package:youapp_challenge/core/services/dio_service.dart';
import 'package:youapp_challenge/features/auth/data/models/auth_response_model.dart';
import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/register_entity.dart';

class RemoteAuthSource with ResponseMixin {
  final DioService _dioService;

  RemoteAuthSource({required DioService dioService}) : _dioService = dioService;

  Future<Response<AuthResponseModel>> postLogin(LoginEntity loginData) async {
    try {
      const path = "/login";

      final result = await _dioService.dio.post(
        path,
        data: {
          "email": loginData.email,
          "username": loginData.username,
          "password": loginData.password,
        }
      );

      handleBugResponseAPI(result, result.data?["message"] == "User not found" || result.data["message"] == "Incorrect password");

      return response(result,  AuthResponseModel.fromJson(result.data));
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<AuthResponseModel>> postRegister(RegisterEntity registerData) async {
    try {
      const path = "/register";

      final result = await _dioService.dio.post(
        path,
        data: {
          "email": registerData.email,
          "username": registerData.username,
          "password": registerData.password,
        }
      );

      handleBugResponseAPI(result, result.data?["message"] == "User already exists");

      return response(result,  AuthResponseModel.fromJson(result.data));
    } catch (e) {
      rethrow;
    }
  }
}
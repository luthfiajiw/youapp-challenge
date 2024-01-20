import 'package:dio/dio.dart';
import 'package:youapp_challenge/core/services/dio_service.dart';
import 'package:youapp_challenge/features/auth/data/models/auth_response_model.dart';
import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';

class RemoteAuthSource {
  final DioService _dioService;

  RemoteAuthSource({required DioService dioService}) : _dioService = dioService;

  Future<Response<AuthResponseModel>> postLogin(LoginEntity loginData) async {
    try {
      const path = "/login";

      final response = await _dioService.dio.post(
        path,
        data: {
          "email": loginData.email,
          "username": loginData.username,
          "password": loginData.password,
        }
      );

      // 
      // this if statement should not be here,
      // I wrote this only because the api has a bug with status code
      // 
      if (
        response.data["message"] == "User not found"
        || response.data["message"] == "Incorrect password"
      ) {
        final exception = DioException(
          requestOptions: response.requestOptions,
          response: Response(
            requestOptions: response.requestOptions,
            statusCode: 400,
            data: response.data
          )
        );

        throw(exception);
      }

      return Response(
        requestOptions: response.requestOptions,
        data: AuthResponseModel.fromJson(response.data),
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        headers: response.headers
      );
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:youapp_challenge/core/services/dio_service.dart';
import 'package:youapp_challenge/features/auth/data/models/auth_response_model.dart';
import 'package:youapp_challenge/features/auth/data/sources/remote_auth_source.dart';
import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late DioService dioService;
  late RemoteAuthSource authSource;

  setUp(() {
    dio = Dio(
      BaseOptions(baseUrl: 'https://techtest.youapp.ai/api')
    );
    dioService = DioService(dio);
    dioAdapter = DioAdapter(
      dio: dio,
      matcher: const UrlRequestMatcher()
    );

    authSource = RemoteAuthSource(dioService: dioService);
  });

  group('Remote Auth Source', () {
    const loginData = LoginEntity(
      email: "email",
      username: "",
      password: "123"
    );

    const resSuccess = {
      "message": "User has been logged in successfully",
      "access_token": "token"
    };

    const resFailed = {
      "message": "User not found"
    };

    test('when login is successfully the response should contain access_token', () async {
      // arrange
      dioAdapter.onPost('/login', (server) {
        return server.reply(201, resSuccess);
      });

      // act
      final response = await authSource.postLogin(loginData);

      // matcher
      const expectedModel = AuthResponseModel(
        message: "User has been logged in successfully",
        accessToken: "token"
      );
      expect(response.data, expectedModel);
    });

    test('when login data is invalid should throw an exception', () {
      // arrange
      dioAdapter.onPost('/login', (server) {
        return server.reply(400, resFailed);
      });

      // act
      expect(
        () async => authSource.postLogin(loginData),
        throwsA(isA<DioException>())
      );

    });
  });
}
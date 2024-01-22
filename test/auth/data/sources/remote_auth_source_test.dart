
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:youapp_challenge/core/services/dio_service.dart';
import 'package:youapp_challenge/features/auth/data/models/auth_response_model.dart';
import 'package:youapp_challenge/features/auth/data/sources/remote_auth_source.dart';
import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/register_entity.dart';

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

    const registerData = RegisterEntity(
      email: "email",
      username: "username",
      password: "123"
    );

    const resLoginSuccess = {
      "message": "User has been logged in successfully",
      "access_token": "token"
    };
    
    const resRegisterSuccess = {
      "message": "User has been created in successfully",
    };

    const resLoginFailed = {
      "message": "User not found"
    };

    const resRegisterFailed = {
      "message": "User already exists"
    };

    group('Login', () {
      test('when login is successfully the response should contain access_token', () async {
        // arrange
        dioAdapter.onPost('/login', (server) {
          return server.reply(201, resLoginSuccess);
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
          return server.reply(201, resLoginFailed);
        });

        // act
        expect(
          () async => authSource.postLogin(loginData),
          throwsA(isA<DioException>())
        );
      });
    });

    group('Register', () {
      test('when register is successfully the response should contain success message', () async {
        // arrange
        dioAdapter.onPost('/register', (server) {
          return server.reply(201, resRegisterSuccess);
        });

        // act
        final response = await authSource.postRegister(registerData);

        // matcher
        const expectedModel = AuthResponseModel(
          message: "User has been created in successfully"
        );
        expect(response.data, expectedModel);
      });

      test('when register data is invalid should throw an exception', () {
        // arrange
        dioAdapter.onPost('/register', (server) {
          return server.reply(201, resRegisterFailed);
        });

        // act
        expect(
          () async => authSource.postRegister(registerData),
          throwsA(isA<DioException>())
        );
      });
    });
  });
}
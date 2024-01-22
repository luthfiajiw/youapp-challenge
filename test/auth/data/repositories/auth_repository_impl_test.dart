
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/core/services/dio_service.dart';
import 'package:youapp_challenge/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:youapp_challenge/features/auth/data/sources/remote_auth_source.dart';
import 'package:youapp_challenge/features/auth/domain/entities/auth_response_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/register_entity.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late DioService dioService;
  late RemoteAuthSource authSource;
  late AuthRepositoryImpl authRepo;

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

    authRepo = AuthRepositoryImpl(source: authSource);
  });

  group('Auth Repo', () {
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
        final response = await authRepo.postLogin(loginData);

        // matcher
        expect(response, isA<DataSuccess<AuthResponseEntity>>());
        expect(response.data?.accessToken, isNotNull);
      });

      test('when login data is invalid should throw an exception', () async {
        // arrange
        dioAdapter.onPost('/login', (server) {
          return server.reply(201, resLoginFailed);
        });

        // act
        final response = await authRepo.postLogin(loginData);

        expect(response, isA<DataFailed<AuthResponseEntity>>());
      });
    });

    group('Login', () {
      test('when register is successfully the response should contain success message', () async {
        // arrange
        dioAdapter.onPost('/register', (server) {
          return server.reply(201, resRegisterSuccess);
        });

        // act
        final response = await authRepo.postRegister(registerData);

        // matcher
        expect(response, isA<DataSuccess<AuthResponseEntity>>());
        expect(response.data?.message, resRegisterSuccess["message"]);
      });

      test('when register data is invalid should throw an exception', () async {
        // arrange
        dioAdapter.onPost('/register', (server) {
          return server.reply(201, resRegisterFailed);
        });

        // act
        final response = await authRepo.postRegister(registerData);

        expect(response, isA<DataFailed<AuthResponseEntity>>());
      });
    });

  });
}
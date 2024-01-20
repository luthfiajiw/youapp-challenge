
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/core/services/dio_service.dart';
import 'package:youapp_challenge/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:youapp_challenge/features/auth/data/sources/remote_auth_source.dart';
import 'package:youapp_challenge/features/auth/domain/entities/auth_response_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';

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
      final response = await authRepo.postLogin(loginData);

      // matcher
      const expectedModel = AuthResponseEntity(
        message: "User has been logged in successfully",
        accessToken: "token"
      );
      expect(response, isA<DataSuccess<AuthResponseEntity>>());
    });

    test('when login data is invalid should throw an exception', () async {
      // arrange
      dioAdapter.onPost('/login', (server) {
        return server.reply(400, resFailed);
      });

      // act
      final response = await authRepo.postLogin(loginData);

      expect(response, isA<DataFailed<AuthResponseEntity>>());
    });
  });
}
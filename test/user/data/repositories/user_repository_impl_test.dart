import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/core/services/dio_service.dart';
import 'package:youapp_challenge/features/user/data/repositories/user_repository_impl.dart';
import 'package:youapp_challenge/features/user/data/source/remote_user_source.dart';
import 'package:youapp_challenge/features/user/domain/entities/form_user_entity.dart';
import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late DioService dioService;
  late RemoteUserSource userSource;
  late UserRepositoryImpl userRepo;

  setUp(() {
    dio = Dio(
      BaseOptions(baseUrl: 'https://techtest.youapp.ai/api')
    );
    dioService = DioService(dio);
    dioAdapter = DioAdapter(
      dio: dio,
      matcher: const UrlRequestMatcher()
    );
    
    userSource = RemoteUserSource(dioService: dioService);

    userRepo = UserRepositoryImpl(source: userSource);
  });

  group('User Repo', () {
    Map<String, dynamic> response = {
      "message": "Profile has been found successfully",
      "data": {
        "email": "ab123@mail.com",
        "username": "ab123",
        "name": "AB",
        "birthday": "2000-09-06",
        "horoscope": "Virgo",
        "zodiac": "Dragon",
        "height": 167,
        "weight": 58,
        "interests": []
      }
    };

    final formUser = FormUserEntity(
      name: response["data"]["name"],
      birthday: response["data"]["birthday"],
      height: response["data"]["height"],
      weight: response["data"]["weight"],
      interests: response["data"]["interests"]
    );

    test('when get user is success should return data success', () async {
      // arrange
      dioAdapter.onGet('/getProfile', (server) {
        return server.reply(200, response);
      });

      // act
      final result = await userRepo.getUser();

      expect(result, isA<DataSuccess<UserResponseEntity>>());
      expect(result.data?.data, isNotNull);
    });

    test('when get user is failed should return data failed', () async {
      // arrange
      dioAdapter.onGet('/getProfile', (server) {
        return server.reply(400, {});
      });

      // act
      final result = await userRepo.getUser();

      expect(result, isA<DataFailed<UserResponseEntity>>());
    });

    test('when put user is success should return data success', () async {
      // arrange
      dioAdapter.onPut(
        '/updateProfile',
        data: {
          "name": response["name"],
          "birthday": response["birthday"],
          "height": response["height"],
          "weight": response["weight"],
          "interests": response["interests"]
        },
        (server) {
          return server.reply(200, response);
        }
      );

      // act
      final result = await userRepo.putUser(formUser);

      expect(result, isA<DataSuccess<UserResponseEntity>>());
      expect(result.data?.data, isNotNull);
    });

    test('when put user is failed should return data failed', () async {
      // arrange
      dioAdapter.onPut('/updateProfile', data: {}, (server) {
        return server.reply(400, {});
      });

      // act
      final result = await userRepo.putUser(formUser);

      expect(result, isA<DataFailed<UserResponseEntity>>());
    });
  });
}
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:youapp_challenge/core/services/dio_service.dart';
import 'package:youapp_challenge/features/user/data/models/user_response_model.dart';
import 'package:youapp_challenge/features/user/data/source/remote_user_source.dart';
import 'package:youapp_challenge/features/user/domain/entities/form_user_entity.dart';
import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late DioService dioService;
  late RemoteUserSource userSource;

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
  });

  group('Remote User Source', () {
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

    const expectedModel = UserResponseModel(
      message: "Profile has been found successfully",
      data: UserEntity(
        email: "ab123@mail.com",
        username: "ab123",
        name: "AB",
        birthday: "2000-09-06",
        horoscope: "Virgo",
        zodiac: "Dragon",
        height: 167,
        weight: 58,
        interests: []
      )
    );

    final formUser = FormUserEntity(
      name: expectedModel.data!.name!,
      birthday: expectedModel.data!.birthday!,
      height: expectedModel.data!.height!,
      weight: expectedModel.data!.weight!,
      interests: expectedModel.data!.interests!
    );

    test('when get user successfully the response should contain data', () async {
      // arrange
      dioAdapter.onGet('/getProfile', (server) {
        return server.reply(200, response);
      });

      // act
      final result = await userSource.getUser();

      expect(result.data, expectedModel);
    });

    test('when get user error should throws exception', () {
      // arrange
      dioAdapter.onGet("/getProfile", (server) {
        return server.reply(400, {});
      });

      // act
      expect(
        () async => userSource.getUser(),
        throwsA(isA<DioException>())
      );
    });

    test('when put user successfully the response should contain data', () async {
      // arrange
      dioAdapter.onPut(
        '/updateProfile',
        data: {
          "name": expectedModel.data?.name,
          "birthday": expectedModel.data?.birthday,
          "height": expectedModel.data?.height,
          "weight": expectedModel.data?.weight,
          "interests": expectedModel.data?.interests
        },
        (server) {
          return server.reply(200, response);
        }
      );

      // act
      final result = await userSource.putUser(formUser);

      expect(result.data, expectedModel);
    });

    test('when put user error should throws exception', () {
      // arrange
      dioAdapter.onPut("/updateProfile", data: {}, (server) {
        return server.reply(400, {});
      });

      // act
      expect(
        () async => userSource.putUser(formUser),
        throwsA(isA<DioException>())
      );
    });
  });
}
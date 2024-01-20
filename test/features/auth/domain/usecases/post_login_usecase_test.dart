import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/features/auth/domain/entities/auth_response_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';
import 'package:youapp_challenge/features/auth/domain/repositories/auth_repository.dart';
import 'package:youapp_challenge/features/auth/domain/usecases/post_login_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late PostLogin usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = PostLogin(authRepository: mockAuthRepository);
  });

  const loginData = LoginEntity(
    email: "ab123@mail.com",
    username: "ab123",
    password: "123456"
  );

  const successResponse = AuthResponseEntity(
    message: "User has been logged in successfully",
    accessToken: "access-token"
  );

  final errorResponse = DioException(
    requestOptions: RequestOptions(),
    response: Response(
      requestOptions: RequestOptions(),
      data: {
        "message": "Incorrect password",
      }
    )
  );

  group("Login Request", () {
    test('when user exists should return data success', () async {
      when(() => mockAuthRepository.postLogin(loginData),)
        .thenAnswer((_) async => DataSuccess(successResponse));

      final response = await usecase(params: loginData);

      expect(response, isA<DataSuccess<AuthResponseEntity>>());
      expect(response.data?.accessToken, isNotNull);
    });

    test('when user is invalid should return data failed', () async {
      when(() => mockAuthRepository.postLogin(loginData),)
        .thenAnswer((_) async => DataFailed(errorResponse));

      final response = await usecase(params: loginData);

      expect(response, isA<DataFailed<AuthResponseEntity>>());
      expect(response.data?.accessToken, isNull);
    });
  });
}
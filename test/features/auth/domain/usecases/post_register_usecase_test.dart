import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/features/auth/domain/entities/auth_response_entity.dart';
import 'package:youapp_challenge/features/auth/domain/entities/register_entity.dart';
import 'package:youapp_challenge/features/auth/domain/repositories/auth_repository.dart';
import 'package:youapp_challenge/features/auth/domain/usecases/post_register_usercase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late PostRegister usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = PostRegister(authRepository: mockAuthRepository);
  });

  const registerData = RegisterEntity(
    email: "ab123@mail.com",
    username: "ab123",
    password: "123456"
  );

  const successResponse = AuthResponseEntity(
    message: "User has been created successfully",
  );

  final errorResponse = DioException(
    requestOptions: RequestOptions(),
    response: Response(
      requestOptions: RequestOptions(),
      data: {
        "message": "User already exists",
      }
    )
  );

  group('Post Register', () {
    test('when user exists should return data failed', () async {
      // arrange
      when(() => mockAuthRepository.postRegister(registerData))
        .thenAnswer((_) async => DataFailed(errorResponse));
      
      // act 
      final response = await usecase(params: registerData);

      expect(response, isA<DataFailed<AuthResponseEntity>>());
    });

    test('when user created successfully should return data success', () async {
      // arrange
      when(() => mockAuthRepository.postRegister(registerData))
        .thenAnswer((_) async => DataSuccess(successResponse));
      
      // act 
      final response = await usecase(params: registerData);

      expect(response, isA<DataSuccess<AuthResponseEntity>>());
    });
  });
}
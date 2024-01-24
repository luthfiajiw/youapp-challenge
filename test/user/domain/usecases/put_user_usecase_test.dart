import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/features/user/domain/entities/form_user_entity.dart';
import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';
import 'package:youapp_challenge/features/user/domain/repositories/user_repository.dart';
import 'package:youapp_challenge/features/user/domain/usecases/put_user_usecase.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late PutUser usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = PutUser(userRepository: mockUserRepository);
  });

  group('Put User', () {
    const form = FormUserEntity(
      name: "",
      birthday: "",
      height: 0,
      weight: 0,
      interests: []
    );

    test('when update user success should return data success', () async {
      when(() => mockUserRepository.putUser(form))
        .thenAnswer((_) async => DataSuccess(const UserResponseEntity()));
      
      final result = await usecase(params: form);

      expect(result, isA<DataSuccess<UserResponseEntity>>());
    });

    test('when update user failed should return data failed', () async {
      when(() => mockUserRepository.putUser(form))
        .thenAnswer((_) async => DataFailed(DioException(requestOptions: RequestOptions())));
      
      final result = await usecase(params: form);

      expect(result, isA<DataFailed<UserResponseEntity>>());
    });
  });
}
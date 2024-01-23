import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';
import 'package:youapp_challenge/features/user/domain/repositories/user_repository.dart';
import 'package:youapp_challenge/features/user/domain/usecases/get_user_usecase.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late GetUser usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetUser(userRepository: mockUserRepository);
  });

  group('Get User', () {
    test('when user exists should return data success', () async {
      // arrange
      when(() => mockUserRepository.getUser())
        .thenAnswer((_) async => DataSuccess(const UserResponseEntity()));
      
      // act
      final response = await usecase();

      expect(response, isA<DataSuccess<UserResponseEntity>>());
    });
  });
}
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';
import 'package:youapp_challenge/features/user/domain/usecases/get_user_usecase.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';

class MockGetUser extends Mock implements GetUser {}

void main() {
  late MockGetUser mockGetUser;
  late UserCubit userCubit;

  setUp(() {
    mockGetUser = MockGetUser();
    userCubit = UserCubit(mockGetUser);
  });

  group('User Cubit', () {
    const userResponseEntity = UserResponseEntity(
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

    blocTest<UserCubit, UserState>(
      'emits [UserState] when getUser is succeed',
      build: () {
        when(() => mockGetUser())
          .thenAnswer((_) async => DataSuccess(userResponseEntity));
        return userCubit;
      },
      act: (cubit) => cubit.onGetUser(),
      expect: () => <UserState>[
        const UserState(getUserStatus: GetUserStatus.loading),
        UserState(
          getUserStatus: GetUserStatus.done,
          email: userResponseEntity.data?.email,
          username: userResponseEntity.data?.username,
          name: userResponseEntity.data?.name,
          birthday: userResponseEntity.data?.birthday,
          horoscope: userResponseEntity.data?.horoscope,
          zodiac: userResponseEntity.data?.zodiac,
          height: userResponseEntity.data?.height,
          weight: userResponseEntity.data?.weight,
          interests: userResponseEntity.data?.interests,
        )
      ],
    );
  });
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/features/user/domain/entities/form_user_entity.dart';
import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';
import 'package:youapp_challenge/features/user/domain/usecases/get_user_usecase.dart';
import 'package:youapp_challenge/features/user/domain/usecases/put_user_usecase.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUser _getUser;
  final PutUser _putUser;

  UserCubit(this._getUser, this._putUser) : super(const UserState());

  Future<void> onGetUser() async {
    try {
      emit(state.copyWith(getUserStatus: GetUserStatus.loading));

      final response = await _getUser();

      if (response is DataSuccess && response.data != null) {
        UserEntity user = response.data!.data!;
        int age = 0;

        if (user.birthday!.isNotEmpty) {
          DateTime birthDate = DateTime.parse(user.birthday!);
          DateTime now = DateTime.now();

          int diffInYears = now.year - birthDate.year;
          if (now.month < birthDate.month ||
              (now.month == birthDate.month && now.day < birthDate.day)) {
            // If today's date is before the birthdate this year, subtract one year.
            diffInYears--;
          }

          age = diffInYears;
        }

        emit(state.copyWith(
          getUserStatus: GetUserStatus.done,
          email: user.email,
          username: user.username,
          name: user.name,
          birthday: user.birthday,
          horoscope: user.horoscope,
          zodiac: user.zodiac,
          age: age,
          height: user.height,
          weight: user.weight,
          interests: user.interests,
        ));
        emit(state.copyWith(getUserStatus: GetUserStatus.idle));
      } else {
        emit(state.copyWith(getUserStatus: GetUserStatus.error));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> onPutUser(FormUserEntity form) async {
    try {
      emit(state.copyWith(putUserStatus: PutUserStatus.submitting));

      final response = await _putUser(params: form);

      if (response is DataSuccess && response.data != null) {
        emit(state.copyWith(putUserStatus: PutUserStatus.done));
        emit(state.copyWith(putUserStatus: PutUserStatus.idle));
      } else {
        emit(state.copyWith(putUserStatus: PutUserStatus.error));
      }
    } catch (e) {
      rethrow;
    }
  }

  void onChangeInterest(List interests) {
    emit(state.copyWith(interests: interests));
  }
}
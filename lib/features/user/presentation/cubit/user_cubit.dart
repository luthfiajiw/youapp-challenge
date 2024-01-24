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

        emit(state.copyWith(
          getUserStatus: GetUserStatus.done,
          email: user.email,
          username: user.username,
          name: user.name,
          birthday: user.birthday,
          horoscope: user.horoscope,
          zodiac: user.zodiac,
          height: user.height,
          weight: user.weight,
          interests: user.interests,
        ));
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
        UserEntity user = response.data!.data!;

        emit(state.copyWith(
          putUserStatus: PutUserStatus.done,
          email: user.email,
          username: user.username,
          name: user.name,
          birthday: user.birthday,
          horoscope: user.horoscope,
          zodiac: user.zodiac,
          height: user.height,
          weight: user.weight,
          interests: user.interests,
        ));
      } else {
        emit(state.copyWith(putUserStatus: PutUserStatus.error));
      }
    } catch (e) {
      rethrow;
    }
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/core/services/shared_prefs_service.dart';
import 'package:youapp_challenge/features/auth/presentation/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SharedPrefsService sharedPrefs;

  SplashCubit(this.sharedPrefs) : super(InitSplashState());

  void authCheck() {
    final String? accessToken = sharedPrefs.getAccessToken();

    if (accessToken != null) {
      emit(AccessTokenExists());
    } else {
      emit(AccessTokenEmpty());
    }
  }
}
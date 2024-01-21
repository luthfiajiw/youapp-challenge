import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/core/resources/data_state.dart';
import 'package:youapp_challenge/core/services/shared_prefs_service.dart';
import 'package:youapp_challenge/features/auth/domain/entities/login_entity.dart';
import 'package:youapp_challenge/features/auth/domain/usecases/post_login_usecase.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PostLogin postLogin;
  final SharedPrefsService sharedPrefs;

  AuthBloc(this.postLogin, this.sharedPrefs): super(const AuthState()) {
    on<AuthEmailChanged>(_onChangeEmail);
    on<AuthPasswordChanged>(_onChangePassword);
    on<ToggleShowPassword>(_onToggleShowPassword);
    on<LoginSubmitted>(_onSubmitLogin);
  }

  void _onChangeEmail(AuthEmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onChangePassword(AuthPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onToggleShowPassword(ToggleShowPassword event, Emitter<AuthState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword!));
  }

  void _onSubmitLogin(LoginSubmitted event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(authStatus: AuthSubmissionStatus.submitting));

      final params = LoginEntity(email: state.email!, password: state.password!);
      final response = await postLogin(params: params);

      if (response is DataSuccess && response.data != null) {
        sharedPrefs.setAccessToken(response.data!.accessToken!);
        emit(state.copyWith(authStatus: AuthSubmissionStatus.done));
      } else if (response is DataFailed) {
        emit(state.copyWith(authStatus: AuthSubmissionStatus.error));
      }
    } catch (e) {
      rethrow;
    }
  }
}
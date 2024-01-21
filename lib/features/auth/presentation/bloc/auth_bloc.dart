import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/features/auth/domain/usecases/post_login_usecase.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PostLogin postLogin;

  AuthBloc(this.postLogin): super(AuthState()) {
    on<AuthEmailChanged>(_onChangeEmail);
    on<AuthPasswordChanged>(_onChangePassword);
    on<ToggleShowPassword>(_onToggleShowPassword);
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
}
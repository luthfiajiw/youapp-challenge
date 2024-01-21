import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitSplashState extends SplashState {}

class AccessTokenExists extends SplashState {}

class AccessTokenEmpty extends SplashState {}
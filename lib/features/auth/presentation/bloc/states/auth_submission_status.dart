import 'package:dio/dio.dart';

abstract class AuthSubmissionStatus {
  const AuthSubmissionStatus();
}

class InitialAuthStatus extends AuthSubmissionStatus {
  const InitialAuthStatus();
}

class AuthSubmitting extends AuthSubmissionStatus {}

class AuthSubmissionSuccess extends AuthSubmissionStatus {}

class AuthSubmissionFailed extends AuthSubmissionStatus {
  final DioException exception;

  AuthSubmissionFailed(this.exception);
}
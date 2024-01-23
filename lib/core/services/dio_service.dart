import 'package:dio/dio.dart';
import 'package:youapp_challenge/core/services/dio_interceptor.dart';

class DioService {
  final Dio _dio;
  final DioInterceptor? interceptor;

  DioService(this._dio, {this.interceptor}) {
    if (interceptor != null) {
      _dio.interceptors.add(interceptor!);
    }
  }

  Dio get dio => _dio;
}
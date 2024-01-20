import 'package:dio/dio.dart';

class DioService {
  final Dio _dio;

  DioService(this._dio);

  Dio get dio => _dio;
}
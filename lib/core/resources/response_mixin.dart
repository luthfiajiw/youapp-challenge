import 'package:dio/dio.dart';

mixin ResponseMixin {
  Response<T> response<T>(Response response, T data) {
    return Response<T>(
      requestOptions: response.requestOptions,
      data: data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      headers: response.headers
    );
  }

  void handleBugResponseAPI(Response response, bool isError) {
    // 
    // this if statement should not be here,
    // I wrote this only because the api has a bug with status code
    // 
    if (isError) {
      final exception = DioException(
        requestOptions: response.requestOptions,
        response: Response(
          requestOptions: response.requestOptions,
          statusCode: 400,
          data: response.data
        )
      );

      throw(exception);
    }
  }
}
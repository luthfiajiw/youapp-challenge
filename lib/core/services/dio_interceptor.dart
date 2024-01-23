import 'package:dio/dio.dart';
import 'package:youapp_challenge/core/services/locator_service.dart';
import 'package:youapp_challenge/core/services/shared_prefs_service.dart';

class DioInterceptor extends Interceptor {
  final prefs = locator.get<SharedPrefsService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final endpoint = options.path.split("/").last;

    if (endpoint != "login" || endpoint != "register") {
      options.headers["x-access-token"] = prefs.getAccessToken();
    }
    super.onRequest(options, handler);
  }
}
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  final SharedPreferences prefs;

  SharedPrefsService({required this.prefs});

  // Keys
  String accessToken = "access_token";

  // Access Token
  Future<void> setAccessToken(String token) async {
    await prefs.setString(accessToken, token);
  }

  String? getAccessToken() {
    final token = prefs.getString(accessToken);
    return token;
  }
  // =============

}
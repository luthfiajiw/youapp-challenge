import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_challenge/features/auth/data/models/auth_response_model.dart';

void main() {
  Map<String, dynamic> resSuccess = {
    "message": "User has been logged in successfully",
    "access_token": "token"
  };

  Map<String, dynamic> resFailed = {
    "message": "Invalid password",
  };

  group('Auth Response Model', () {
    test('when encode auth response model from succeed json should not error', () {
      const expectedSuccessModel = AuthResponseModel(
        message: "User has been logged in successfully",
        accessToken: "token"
      );

      expect(AuthResponseModel.fromJson(resSuccess), expectedSuccessModel);
    });

    test('when encode auth response model from failed json should not error', () {
      const expectedFailedModel = AuthResponseModel(
        message: "Invalid password",
      );

      expect(AuthResponseModel.fromJson(resFailed), expectedFailedModel);
    });
  });
}
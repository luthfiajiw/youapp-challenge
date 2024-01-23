import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_challenge/features/user/data/models/user_response_model.dart';
import 'package:youapp_challenge/features/user/domain/entities/user_entity.dart';

void main() {
  Map<String, dynamic> response = {
    "message": "Profile has been found successfully",
    "data": {
      "email": "ab123@mail.com",
      "username": "ab123",
      "name": "AB",
      "birthday": "2000-09-06",
      "horoscope": "Virgo",
      "zodiac": "Dragon",
      "height": 167,
      "weight": 58,
      "interests": []
    }
  };

  group('User Response Model', () {
    test('when encode user response model from response should not error', () {
      const expectedModel = UserResponseModel(
        message: "Profile has been found successfully",
        data: UserEntity(
          email: "ab123@mail.com",
          username: "ab123",
          name: "AB",
          birthday: "2000-09-06",
          horoscope: "Virgo",
          zodiac: "Dragon",
          height: 167,
          weight: 58,
          interests: []
        )
      );

      expect(UserResponseModel.fromJson(response), expectedModel);
    });
  });
}
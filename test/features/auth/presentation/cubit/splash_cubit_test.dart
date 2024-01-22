import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_challenge/core/services/shared_prefs_service.dart';
import 'package:youapp_challenge/features/auth/presentation/cubit/splash_cubit.dart';
import 'package:youapp_challenge/features/auth/presentation/cubit/splash_state.dart';

void main() {
  late SharedPrefsService sharedPrefService;
  late SplashCubit splashCubit;

  setUp(() async {
    // Mock Shared Prefs
    SharedPreferences.setMockInitialValues({});
    final mockPrefs = await SharedPreferences.getInstance();

    sharedPrefService = SharedPrefsService(prefs: mockPrefs);
    splashCubit = SplashCubit(sharedPrefService);
  });

  group('Splash Cubit', () {
    blocTest<SplashCubit, SplashState>(
      'emits [AccessTokenExists] when accessToken is stored in pref',
      build: () {
        sharedPrefService.setAccessToken("token");
        return splashCubit;
      },
      act: (cubit) => cubit.authCheck(),
      expect: () {
        expect(sharedPrefService.getAccessToken(), "token");
        return <SplashState>[AccessTokenExists()];
      },
    );

    blocTest<SplashCubit, SplashState>(
      'emits [AccessTokenEmpty] when accessToken is null',
      build: () => splashCubit,
      act: (cubit) => cubit.authCheck(),
      expect: () => <SplashState>[AccessTokenEmpty()],
    );
  });
}
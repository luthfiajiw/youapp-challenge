import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_challenge/core/services/shared_prefs_service.dart';
import 'package:youapp_challenge/features/auth/presentation/cubit/splash_cubit.dart';
import 'package:youapp_challenge/features/auth/presentation/views/splash_view.dart';


void main() {
  late MockNavigator mockNavigator;
  late SplashCubit splashCubit;
  late SharedPrefsService sharedPrefService;

  setUp(() async {
    // Mock Navigator
    mockNavigator = MockNavigator();

    // Mock Shared Prefs
    SharedPreferences.setMockInitialValues({});
    final mockPrefs = await SharedPreferences.getInstance();

    sharedPrefService = SharedPrefsService(prefs: mockPrefs);
    splashCubit = SplashCubit(sharedPrefService);
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider(
      create: (context) => splashCubit,
      child: MaterialApp(
        home: MockNavigatorProvider(
          navigator: mockNavigator,
          child: body,
        ),
      ),
    );
  }

  group('Splash View', () {
    testWidgets("when accessToken is empty should navigate to LoginView", (tester) async {
      when(mockNavigator.canPop).thenReturn(true);
      when(() => mockNavigator.pushReplacementNamed(any())).thenAnswer((_) async => null);

      await tester.pumpWidget(makeTestableWidget(const SplashView()));
      await tester.pump(const Duration(seconds: 2));

      // finders
      final logoFinder = find.byKey(const Key('logo'));
      expect(logoFinder, findsOneWidget);

      verify(() => mockNavigator.pushReplacementNamed('/login')).called(1);
    });
  });
}

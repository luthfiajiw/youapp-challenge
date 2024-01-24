import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/user_header.dart';

class MockUserCubit extends MockCubit<UserState> implements UserCubit {}

void main() {
  late MockUserCubit mockUserCubit;

  setUp(() {
    mockUserCubit = MockUserCubit();
  });

  Widget userHeader() {
    return MaterialApp(
      home: BlocProvider<UserCubit>(
        create: (context) => mockUserCubit,
        child: const UserHeader(),
      ),
    );
  }

  group('User Header', () {
    // finders
    final usernameTextFinder = find.byKey(const Key("username"));
    final horoscopeChipFinder = find.byKey(const Key("horo-chip"));
    final zodiacChipFinder = find.byKey(const Key("zod-chip"));

    testWidgets("initial state", (tester) async {
      // arrange
      when(() => mockUserCubit.state,).thenReturn(const UserState());

      await tester.pumpWidget(userHeader());

      expect(usernameTextFinder, findsNothing);
      expect(horoscopeChipFinder, findsNothing);
      expect(zodiacChipFinder, findsNothing);
    });

    testWidgets("show username, age, horoscope & zodiac when state is udpated", (tester) async {
      // arrange
      when(() => mockUserCubit.state,)
        .thenReturn(const UserState(username: "username", age: 10, horoscope: "Virgo", zodiac: "Dragon"));

      await tester.pumpWidget(userHeader());

      expect(usernameTextFinder, findsOneWidget);
      expect(horoscopeChipFinder, findsOneWidget);
      expect(zodiacChipFinder, findsOneWidget);
    });
  });
}
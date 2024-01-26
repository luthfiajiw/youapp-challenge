import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/user_interest.dart';

class MockUserCubit extends MockCubit<UserState> implements UserCubit {}

void main() {
  late MockUserCubit mockUserCubit;

  setUp(() {
    mockUserCubit = MockUserCubit();
  });

  Widget userInterest() {
    return MaterialApp(
      home: BlocProvider<UserCubit>(
        create: (context) => mockUserCubit,
        child: Scaffold(
          body: ListView(
            children: const [
              UserInterest(),
            ],
          ),
        ),
      ),
    );
  }

  group('User Interest Widget', () {
    // finders
    final initInterestFinder = find.byKey(const Key("initial-interest"));
    final chipMusicFinder = find.byKey(const Key("Music"));

    testWidgets("initial state", (tester) async {
      // arrange
      when(() => mockUserCubit.state,).thenReturn(const UserState());

      await tester.pumpWidget(userInterest());

      expect(initInterestFinder, findsOneWidget);
      expect(chipMusicFinder, findsNothing);
    });

    testWidgets("when interest is not empty should find 1 chip", (tester) async {
      // arrange
      when(() => mockUserCubit.state,)
        .thenReturn(const UserState(interests: ["Music"]));

      await tester.pumpWidget(userInterest());

      expect(initInterestFinder, findsNothing);
      expect(chipMusicFinder, findsOneWidget);
    });
  });
}
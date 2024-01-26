import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_challenge/features/user/domain/entities/form_user_entity.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';
import 'package:youapp_challenge/features/user/presentation/views/interests_view.dart';

class MockUserCubit extends MockCubit<UserState> implements UserCubit {}

void main() {
  late MockUserCubit mockUserCubit;

  setUp(() {
    mockUserCubit = MockUserCubit();
  });

  Widget interestsView() {
    return MaterialApp(
      home: BlocProvider<UserCubit>(
        create: (context) => mockUserCubit,
        child: const InterestsView()
      )
    );
  }

  group('Interests View ', () {
    // finders
    final btnSaveFinder = find.byKey(const Key("btn-save-interests"));
    final chipMusicFinder = find.byKey(const Key("Music"));
    final tfInterestFinder = find.byKey(const Key("tf-interest"));
    final screenLoadingFinder = find.byType(Dialog);

    testWidgets('initial state', (tester) async {
      // arrange
      when(() => mockUserCubit.state,).thenReturn(const UserState());

      await tester.pumpWidget(interestsView());

      expect(btnSaveFinder, findsOneWidget);
      expect(chipMusicFinder, findsNothing);
      expect(tfInterestFinder, findsOneWidget);
    });

    testWidgets('when interests is not empty should find 1 chip', (tester) async {
      // arrange
      when(() => mockUserCubit.state,).thenReturn(const UserState(interests: ["Music"]));

      await tester.pumpWidget(interestsView());

      expect(chipMusicFinder, findsOneWidget);
    });

    testWidgets('when update user is submitting then show screen loading', (tester) async {
      const form = FormUserEntity(
        name: "",
        birthday: "",
        height: 0,
        weight: 0,
        interests: ["Music"],
      );
      
      // arrange
      when(() => mockUserCubit.state,).thenReturn(const UserState(interests: ["Music"]));
      when(() => mockUserCubit.onPutUser(form),).thenAnswer((invocation) async {});

      await tester.pumpWidget(interestsView());

      await tester.tap(btnSaveFinder);
      await tester.pump();

      expect(screenLoadingFinder, findsOneWidget); 
    });
  });
}
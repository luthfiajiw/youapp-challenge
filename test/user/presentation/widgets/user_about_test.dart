import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_challenge/features/user/domain/entities/form_user_entity.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/user_about.dart';

class MockUserCubit extends MockCubit<UserState> implements UserCubit {}

void main() {
  late MockUserCubit mockUserCubit;

  setUp(() {
    mockUserCubit = MockUserCubit();
  });

  Widget userAbout() {
    return MaterialApp(
      home: BlocProvider<UserCubit>(
        create: (context) => mockUserCubit,
        child: Scaffold(
          body: ListView(
            children: const [
              UserAbout(),
            ],
          ),
        ),
      ),
    );
  }

  group('User About Widget', () {
    // finders button
    final btnEditFinder = find.byKey(const Key("btn-edit-about"));
    final btnSaveFinder = find.byKey(const Key("btn-save-about"));

    // dialogs
    final screenLoadingFinder = find.byType(Dialog);

    // texts
    final initialAboutFinder = find.byKey(const Key("initial-about"));
    final sectionAboutFinder = find.byKey(const Key("section-about"));

    // form
    final formAboutFinder = find.byKey(const Key("form-about"));

    testWidgets("initial state", (tester) async {
      when(() => mockUserCubit.state,).thenReturn(const UserState());
      
      await tester.pumpWidget(userAbout());
      
      // expect buttons
      expect(btnEditFinder, findsOneWidget);
      expect(btnSaveFinder, findsNothing);

      // texts
      expect(sectionAboutFinder, findsNothing);
      expect(initialAboutFinder, findsOneWidget);

      // forms
      expect(formAboutFinder, findsOneWidget);
    });

    testWidgets("when update user is submitting then show screen loading", (tester) async {
      const form = FormUserEntity(
        name: "",
        birthday: "",
        height: 0,
        weight: 0,
        interests: [],
      );
      
      // arrange
      when(() => mockUserCubit.state,).thenReturn(const UserState());
      when(() => mockUserCubit.onPutUser(form),).thenAnswer((invocation) async {});

      await tester.pumpWidget(userAbout());

      await tester.tap(btnEditFinder);
      await tester.pumpAndSettle();

      expect(btnSaveFinder, findsOneWidget);

      await tester.tap(btnSaveFinder);
      await tester.pump();

      expect(screenLoadingFinder, findsOneWidget);      
    });
  });
}
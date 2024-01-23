import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_state.dart';
import 'package:youapp_challenge/features/auth/presentation/views/register_view.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockNavigator mockNavigator;
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockNavigator = MockNavigator();
    mockAuthBloc = MockAuthBloc();

    // stub naviagtor
    when(mockNavigator.canPop).thenReturn(true);
    when(() => mockNavigator.pop()).thenAnswer((_) async {});
  });

  registerView(Widget child) {
    return MaterialApp(
      home: MockNavigatorProvider(
        navigator: mockNavigator,
        child: child,
      ),
    );
  }
  
  group("Register View", () {
    // Finders
    final titleFinder = find.text('Register');
    final emailTextfieldFinder = find.byKey(const Key('email'));
    final usernameTextfieldFinder = find.byKey(const Key('username'));
    final createPasswordTextfieldFinder = find.byKey(const Key('create-password'));
    final confirmPasswordTextfieldFinder = find.byKey(const Key('confirm-password'));
    final btnRegisterFinder = find.byKey(const Key('btn-register'));
      
    testWidgets("has 4 textfield and 1 button", (tester) async {
      when(() => mockAuthBloc.state,).thenReturn(const AuthState());
      
      await tester.pumpWidget(registerView(RegisterView(authBloc: mockAuthBloc, formKey: GlobalKey<FormState>())));

      expect(titleFinder, findsNWidgets(2));
      expect(emailTextfieldFinder, findsOneWidget);
      expect(usernameTextfieldFinder, findsOneWidget);
      expect(createPasswordTextfieldFinder, findsOneWidget);
      expect(confirmPasswordTextfieldFinder, findsOneWidget);
      expect(btnRegisterFinder, findsOneWidget);
    });

    testWidgets("when AuthSubmissionStatus is done should navigate back to LoginView", (tester) async {
      // arrange
      when(() => mockAuthBloc.state,).thenReturn(const AuthState());
      when(() => mockAuthBloc.add(AuthEmailChanged(email: "email@mail.com"))).thenAnswer((_) async {});
      when(() => mockAuthBloc.add(AuthUsernameChanged(username: "ab"))).thenAnswer((_) async {});
      when(() => mockAuthBloc.add(AuthPasswordChanged(password: "12345678"))).thenAnswer((_) async {});
      when(() => mockAuthBloc.add(AuthConfirmPasswordChanged(password: "12345678"))).thenAnswer((_) async {});
      when(() => mockAuthBloc.add(RegisterSubmitted())).thenAnswer((_) async {});
      whenListen(
        mockAuthBloc, 
        Stream.fromIterable(const [
          AuthState(),
          AuthState(email: "email", username: null, password: null, confirmPassword: null, showPassword: false, showConfirmPassword: false, authStatus: AuthSubmissionStatus.idle, confirmPasswordAutovalidate: AutovalidateMode.disabled),
          AuthState(email: "email", username: "ab", password: null, confirmPassword: null, showPassword: false, showConfirmPassword: false, authStatus: AuthSubmissionStatus.idle, confirmPasswordAutovalidate: AutovalidateMode.disabled),
          AuthState(email: "email", username: "ab", password: "password", confirmPassword: null, showPassword: false, showConfirmPassword: false, authStatus: AuthSubmissionStatus.idle, confirmPasswordAutovalidate: AutovalidateMode.disabled),
          AuthState(email: "email", username: "ab", password: "password", confirmPassword: "password", showPassword: false, showConfirmPassword: false, authStatus: AuthSubmissionStatus.idle, confirmPasswordAutovalidate: AutovalidateMode.disabled),
          AuthState(email: "email", username: "ab", password: "password", confirmPassword: "password", showPassword: false, showConfirmPassword: false, authStatus: AuthSubmissionStatus.submitting, confirmPasswordAutovalidate: AutovalidateMode.disabled),
          AuthState(email: "email", username: "ab", password: "password", confirmPassword: "password", showPassword: false, showConfirmPassword: false, authStatus: AuthSubmissionStatus.done, confirmPasswordAutovalidate: AutovalidateMode.disabled),
        ])
      );

      final formKey = GlobalKey<FormState>();
      RegisterView view = RegisterView(authBloc: mockAuthBloc, formKey: formKey,);
      await tester.pumpWidget(registerView(view));

      // act
      await tester.enterText(emailTextfieldFinder, "email@mail.com");
      await tester.enterText(usernameTextfieldFinder, "ab");
      await tester.enterText(createPasswordTextfieldFinder, "12345678");
      await tester.enterText(confirmPasswordTextfieldFinder, "12345678");
      await tester.pump();
      expect(formKey.currentState?.validate(), isTrue);

      await tester.tap(btnRegisterFinder);

      expect(find.text("email@mail.com"), findsOneWidget);
      expect(find.text("ab"), findsOneWidget);
      expect(find.text("12345678"), findsNWidgets(2));

      // expect error validation
      expect(find.text("Email is invalid"), findsOneWidget);

      // verify event is called
      verify(() => mockAuthBloc.add(RegisterSubmitted())).called(1);

    });
  });

  testWidgets('TextFormField test', (WidgetTester tester) async {
    // Define the key.
    final key = GlobalKey<FormState>();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Form(
          key: key,
          child: TextFormField(
            validator: (value) {
              if (value?.isEmpty ?? false) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
      ),
    ));

    // Interact with the text field and enter text.
    await tester.enterText(find.byType(TextFormField), 'Hello Flutter');

    // Trigger a frame.
    await tester.pump();

    // Check if the TextFormField shows the entered text.
    expect(find.text('Hello Flutter'), findsOneWidget);

    // Optionally (if you want to check form validation):
    // Verify that the form is valid.
    bool? isValid = key.currentState?.validate();
    expect(isValid, isTrue); // or isFalse if expecting validation to fail.
  });
}
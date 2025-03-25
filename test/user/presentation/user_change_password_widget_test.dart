import 'package:clean_architecture_example/main.dart';
import 'package:clean_architecture_example/user/controller/user_controller.dart';
import 'package:clean_architecture_example/user/presentation/user_change_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockUserController extends Mock implements UserController {}

void main() {
  late MockUserController mockUserController;

  setUp(() {
    mockUserController = MockUserController();
    if (getIt.isRegistered<UserController>()) {
      getIt.unregister<UserController>();
    }
    getIt.registerSingleton<UserController>(mockUserController);
  });

  Future<void> pumpWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<UserController>.value(
        value: mockUserController,
        child: MaterialApp(
          home: Scaffold(
            body: UserChangePasswordWidget(
              email: 'user@example.com',
              firstName: 'John',
              lastName: 'Doe',
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('should change password successfully', (WidgetTester tester) async {
    await pumpWidget(tester);

    final newPasswordField = find.byType(TextField).at(0);
    final confirmPasswordField = find.byType(TextField).at(1);
    final changePasswordButton = find.text('Change');

    await tester.enterText(newPasswordField, 'NewPassword123');
    await tester.enterText(confirmPasswordField, 'NewPassword123');

    when(() => mockUserController.updatePassword(any(), any())).thenAnswer((_) async {});

    await tester.tap(changePasswordButton);
    await tester.pumpAndSettle();

    verify(() => mockUserController.updatePassword('user@example.com', 'NewPassword123')).called(1);
  });

  testWidgets('should show error message when passwords do not match', (WidgetTester tester) async {
    await pumpWidget(tester);

    final newPasswordField = find.byType(TextField).at(0);
    final confirmPasswordField = find.byType(TextField).at(1);
    final changePasswordButton = find.text('Change');

    await tester.enterText(newPasswordField, 'NewPassword123');
    await tester.enterText(confirmPasswordField, 'DifferentPassword123');

    await tester.tap(changePasswordButton);
    await tester.pumpAndSettle();

    expect(find.text('Passwords do not match'), findsOneWidget);
  });
}
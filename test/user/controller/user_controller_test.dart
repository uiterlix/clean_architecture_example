import 'package:clean_architecture_example/user/interface_adapters/controller/user_controller.dart';
import 'package:clean_architecture_example/user/usecase/add_user_usecase.dart';
import 'package:clean_architecture_example/user/usecase/delete_user_usecase.dart';
import 'package:clean_architecture_example/user/usecase/get_users_usecase.dart';
import 'package:clean_architecture_example/user/usecase/send_welcome_email_usecase.dart';
import 'package:clean_architecture_example/user/usecase/update_password_usecase.dart';
import 'package:clean_architecture_example/user/usecase/user_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddUser extends Mock implements AddUser {}
class MockGetUsers extends Mock implements GetUsers {}
class MockDeleteUser extends Mock implements DeleteUser {}
class MockUpdateUserPassword extends Mock implements UpdateUserPassword {}
class MockSendWelcomeEmail extends Mock implements SendWelcomeEmail {}

void main() {
  late UserController userController;
  late MockAddUser mockAddUser;
  late MockGetUsers mockGetUsers;
  late MockDeleteUser mockDeleteUser;
  late MockUpdateUserPassword mockUpdateUserPassword;
  late MockSendWelcomeEmail mockSendWelcomeEmail;

  setUp(() {
    mockAddUser = MockAddUser();
    mockGetUsers = MockGetUsers();
    mockDeleteUser = MockDeleteUser();
    mockUpdateUserPassword = MockUpdateUserPassword();
    mockSendWelcomeEmail = MockSendWelcomeEmail();
    userController = UserController(
      mockAddUser,
      mockGetUsers,
      mockDeleteUser,
      mockUpdateUserPassword,
      mockSendWelcomeEmail,
    );
  });

  test('should add user and send welcome email', () async {
    final userDto = UserDTO(
      email: 'user@example.com',
      firstName: 'John',
      lastName: 'Doe',
      password: 'password123',
    );

    when(() => mockAddUser.call(userDto)).thenAnswer((_) async {});
    when(() => mockSendWelcomeEmail.call(userDto)).thenAnswer((_) async {});

    await userController.addUser(userDto);

    verify(() => mockAddUser.call(userDto)).called(1);
    verify(() => mockSendWelcomeEmail.call(userDto)).called(1);
  });

  test('should throw exception when user already exists', () async {
    final userDto = UserDTO(
      email: 'user@example.com',
      firstName: 'John',
      lastName: 'Doe',
      password: 'password123',
    );

    when(() => mockAddUser.call(userDto)).thenThrow(Exception('User already exists'));

    expect(() => userController.addUser(userDto), throwsException);
    verify(() => mockAddUser.call(userDto)).called(1);
    verifyNever(() => mockSendWelcomeEmail.call(userDto));
  });
}
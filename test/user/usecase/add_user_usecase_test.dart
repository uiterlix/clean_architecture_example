import 'package:clean_architecture_example/user/entity/user_entity.dart';
import 'package:clean_architecture_example/user/usecase/user_repository.dart';
import 'package:test/test.dart';
import 'package:clean_architecture_example/user/usecase/add_user_usecase.dart';
import 'package:clean_architecture_example/user/usecase/user_dto.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for UserRepository
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('AddUserUseCase', () {
    late AddUser addUserUseCase;
    late MockUserRepository mockUserRepository;

    setUp(() {
      mockUserRepository = MockUserRepository();
      addUserUseCase = AddUser(mockUserRepository);
      registerFallbackValue(User(email: '', firstName: '', lastName: '', password: ''));
    });

    test('should add a user successfully', () async {
      final user = UserDTO(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        password: 'Password123!',
      );

      // Arrange
      when(() => mockUserRepository.exists(any())).thenAnswer((_) async => false);
      when(() => mockUserRepository.addUser(any())).thenAnswer((_) async => Future.value());

      // Act
      await addUserUseCase.call(user);

      // Assert
      verify(() => mockUserRepository.exists(user.email)).called(1);
      verify(() => mockUserRepository.addUser(any(that: isA<User>()
          .having((user) => user.firstName, 'firstName', 'John')
          .having((user) => user.lastName, 'lastName', 'Doe')
      ))).called(1);
    });

    test('should throw an exception when adding a user fails', () async {
      final user = UserDTO(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        password: 'Password123',
      );

      // Arrange
      when(() => mockUserRepository.exists(any())).thenAnswer((_) async => false);
      when(() => mockUserRepository.addUser(any())).thenThrow(Exception('Failed to add user'));

      // Act & Assert
      expect(() => addUserUseCase.call(user), throwsA(isA<Exception>()));
    });
  });
}
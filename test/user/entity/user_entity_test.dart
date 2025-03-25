import 'package:test/test.dart';
import 'package:clean_architecture_example/user/entity/user_entity.dart';

void main() {
  group('User Entity', () {
    test('should create a valid User', () {
      final user = User(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        password: 'Password123',
      );

      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.email, 'john.doe@example.com');
      expect(user.password, 'Password123');
    });

    test('should throw an exception for invalid password', () {
      expect(
            () => User(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          password: 'short',
        ).validatePassword(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'description', contains('Password must be at least 8 characters long'))),
      );

      expect(
            () => User(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          password: 'NoDigits',
        ).validatePassword(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'description', contains('Password must contain at least one digit'))),
      );

      expect(
            () => User(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          password: 'nouppercase1',
        ).validatePassword(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'description', contains('Password must contain at least one uppercase letter'))),
      );
    });

    test('should copy user with new password', () {
      final user = User(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        password: 'Password123',
      );

      final updatedUser = user.copyWith(newPassword: 'NewPassword123');

      expect(updatedUser.password, 'NewPassword123');
      expect(updatedUser.firstName, 'John');
      expect(updatedUser.lastName, 'Doe');
      expect(updatedUser.email, 'john.doe@example.com');
    });
  });
}
import 'package:clean_architecture_example/user/entity/user_entity.dart';

abstract class UserDatabase {
  Future<void> insertUser(User user);
  Future<void> updateUser(User user);
  Future<List<User>> queryUsers();
  Future<void> deleteUser(String email);
  Future<bool> userExists(String email);
  Future<User> queryUser(String email);
}
import 'package:clean_architecture_example/user/entity/user_entity.dart';

abstract class UserRepository {
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<List<User>> getUsers();
  Future<void> deleteUser(String email);
  Future<bool> exists(String email);
  Future<User> getUser(String email);
}
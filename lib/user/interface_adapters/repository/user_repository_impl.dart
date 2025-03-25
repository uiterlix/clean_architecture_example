import 'package:clean_architecture_example/user/entity/user_entity.dart';
import 'package:clean_architecture_example/user/interface_adapters/repository/user_database.dart';
import 'package:clean_architecture_example/user/usecase/user_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserDatabase userDatabase;

  UserRepositoryImpl(this.userDatabase);

  @override
  Future<void> addUser(User user) => userDatabase.insertUser(user);

  @override
  Future<void> updateUser(User user) => userDatabase.updateUser(user);

  @override
  Future<List<User>> getUsers() => userDatabase.queryUsers();

  @override
  Future<void> deleteUser(String email) => userDatabase.deleteUser(email);

  @override
  Future<bool> exists(String email) => userDatabase.userExists(email);

  @override
  Future<User> getUser(String email) => userDatabase.queryUser(email);
}
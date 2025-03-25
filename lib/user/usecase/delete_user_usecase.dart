import 'package:clean_architecture_example/user/usecase/user_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<void> call(String email) async {
    await repository.deleteUser(email);
  }
}
import 'package:clean_architecture_example/user/entity/user_entity.dart';
import 'package:clean_architecture_example/user/usecase/user_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class UpdateUserPassword {
  final UserRepository repository;

  UpdateUserPassword(this.repository);

  Future<void> call(String eMail, String newPassword) async {
    User user = await repository.getUser(eMail); // throws exception when user not found
    User newUser = user.copyWith(newPassword: newPassword);
    newUser.validatePassword();
    repository.updateUser(newUser);
  }
}
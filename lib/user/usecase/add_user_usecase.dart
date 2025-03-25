import 'package:clean_architecture_example/user/usecase/user_dto.dart';
import 'package:clean_architecture_example/user/entity/user_entity.dart';
import 'package:clean_architecture_example/user/usecase/user_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class AddUser {
  final UserRepository repository;

  AddUser(this.repository);

  Future<void> call(UserDTO userDto) async {
    if (await repository.exists(userDto.email)) {
      throw Exception('User already exists');
    }
    User user = User(email: userDto.email, firstName: userDto.firstName, lastName: userDto.lastName, password: userDto.password);
    user.validatePassword();
    await repository.addUser(user);
  }
}
import 'package:clean_architecture_example/user/usecase/user_dto.dart';
import 'package:clean_architecture_example/user/usecase/user_mapper.dart';
import 'package:clean_architecture_example/user/usecase/user_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<List<UserDTO>> call() async {
    final users = await repository.getUsers();
    return UserMapper.toDTOList(users);
  }
}

import 'package:clean_architecture_example/user/entity/user_entity.dart';
import 'package:clean_architecture_example/user/usecase/user_dto.dart';

class UserMapper {
  static UserDTO toDTO(User user) {
    return UserDTO(
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      password: user.password,
    );
  }

  static List<UserDTO> toDTOList(List<User> users) {
    return users.map((user) => toDTO(user)).toList();
  }
}
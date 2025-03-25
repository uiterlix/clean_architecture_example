import 'package:clean_architecture_example/user/usecase/user_dto.dart';
import 'package:clean_architecture_example/user/usecase/add_user_usecase.dart';
import 'package:clean_architecture_example/user/usecase/delete_user_usecase.dart';
import 'package:clean_architecture_example/user/usecase/get_users_usecase.dart';
import 'package:clean_architecture_example/user/usecase/update_password_usecase.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class UserController {
  final AddUser addUserUsecase;
  final GetUsers getUsersUsecase;
  final DeleteUser deleteUserUsecase;
  final UpdateUserPassword updatePasswordUsecase;

  UserController(this.addUserUsecase, this.getUsersUsecase, this.deleteUserUsecase, this.updatePasswordUsecase);

  Future<void> addUser(UserDTO user) async {
    await addUserUsecase.call(user);
  }

  Future<List<UserDTO>> getUsers() async {
    return await getUsersUsecase.call();
  }

  Future<void> deleteUser(String email) async {
    await deleteUserUsecase.call(email);
  }

  Future<void> updatePassword(String eMail, String newPassword) async {
    await updatePasswordUsecase.call(eMail, newPassword);
  }
}
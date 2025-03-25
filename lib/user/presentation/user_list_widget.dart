import 'package:clean_architecture_example/main.dart';
import 'package:clean_architecture_example/user/controller/user_controller.dart';
import 'package:clean_architecture_example/user/presentation/user_add_widget.dart';
import 'package:clean_architecture_example/user/presentation/user_change_password_widget.dart';
import 'package:clean_architecture_example/user/usecase/user_dto.dart';
import 'package:flutter/material.dart';

class UserListWidget extends StatefulWidget {
  @override
  _UserListWidgetState createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  late UserController userController = getIt<UserController>();
  List<UserDTO> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final loadedUsers = await userController.getUsers();
    setState(() {
      users = loadedUsers;
    });
  }

  void _addUser() async {
    await _showAddUserDialog();
    _loadUsers();
  }

  Future<void> _showAddUserDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return UserAddWidget();
      },
    );
  }

  void _deleteUser(String email) async {
    await userController.deleteUser(email);
    _loadUsers();
  }

  Future<void> _changePassword(String email, String firstName, String lastName) async {
    await showDialog(
      context: context,
      builder: (context) {
        return UserChangePasswordWidget(email: email, firstName: firstName, lastName: lastName,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.lock),
                  onPressed: () => _changePassword(user.email, user.firstName, user.lastName),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteUser(user.email),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        child: Icon(Icons.add),
      ),
    );
  }
}
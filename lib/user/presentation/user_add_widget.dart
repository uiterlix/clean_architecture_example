import 'package:clean_architecture_example/main.dart';
import 'package:clean_architecture_example/user/controller/user_controller.dart';
import 'package:clean_architecture_example/user/usecase/user_dto.dart';
import 'package:flutter/material.dart';

class UserAddWidget extends StatefulWidget {
  @override
  _UserAddWidgetState createState() => _UserAddWidgetState();
}

class _UserAddWidgetState extends State<UserAddWidget> {
  late UserController userController = getIt<UserController>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _errorMessage;
  bool _obscureText = true;

  void _addUser() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'All fields are mandatory';
      });
      return;
    }

    final newUser = UserDTO(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    try {
      await userController.addUser(newUser);
      setState(() {
        _errorMessage = null;
      });
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Enter user details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                obscureText: _obscureText,
              ),
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _addUser,
                    child: Text('Add'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
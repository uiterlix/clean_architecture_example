import 'package:clean_architecture_example/main.dart';
import 'package:clean_architecture_example/user/interface_adapters/controller/user_controller.dart';
import 'package:flutter/material.dart';

class UserChangePasswordWidget extends StatefulWidget {
  final String email;
  final String firstName;
  final String lastName;

  UserChangePasswordWidget({required this.email, required this.firstName, required this.lastName});

  @override
  _UserChangePasswordWidgetState createState() => _UserChangePasswordWidgetState();
}

class _UserChangePasswordWidgetState extends State<UserChangePasswordWidget> {
  late UserController userController = getIt<UserController>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String? _errorMessage;
  bool _obscureText = true;

  void _changePassword() async {
    if (passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'All fields are mandatory';
      });
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    try {
      await userController.updatePassword(widget.email, passwordController.text);
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
                'Change Password for ${widget.firstName} ${widget.lastName}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
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
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
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
                    onPressed: _changePassword,
                    child: Text('Change'),
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
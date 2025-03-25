class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  User({required this.firstName, required this.lastName, required this.email, required this.password});

  void validatePassword() {
    if (password.length < 8) {
      throw Exception("Password must be at least 8 characters long");
    }
    if (!password.contains(RegExp(r'\d'))) {
      throw Exception("Password must contain at least one digit");
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      throw Exception("Password must contain at least one uppercase letter");
    }
  }

  User copyWith({required String newPassword}) {
    return User(firstName: firstName, lastName: lastName, email: email, password: newPassword);
  }
}

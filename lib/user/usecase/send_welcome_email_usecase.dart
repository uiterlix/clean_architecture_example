import 'package:clean_architecture_example/user/usecase/email_service.dart';
import 'package:clean_architecture_example/user/usecase/user_dto.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class SendWelcomeEmail {
  final EmailService emailService;

  SendWelcomeEmail(this.emailService);

  Future<void> call(UserDTO user) async {
    final email = user.email;
    final subject = 'Welcome to our app';
    final body = 'Hello ${user.firstName} ${user.lastName}, welcome to our company!';

    await emailService.send(email, subject, body);
  }
}
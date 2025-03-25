import 'package:clean_architecture_example/user/usecase/email_service.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: EmailService)
class DummyEmailService implements EmailService {
  @override
  Future<void> send(String email, String subject, String body) async {
    print('Sending email to $email with subject: $subject and body: $body');
  }
}
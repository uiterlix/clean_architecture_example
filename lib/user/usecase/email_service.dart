abstract class EmailService {
  Future<void> send(String email, String subject, String body);
}
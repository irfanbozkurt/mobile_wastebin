import 'user.dart';

class Attachment {
  final String url;

  const Attachment({required this.url});
}

class Email {
  final User sender;
  final List<User> recipients;
  final String subject, content;
  final List<Attachment> attachments;
  final double replies;

  const Email({
    required this.sender,
    required this.recipients,
    required this.subject,
    required this.content,
    this.replies = 0,
    this.attachments = const [],
  });
}

class Message {
  final String text;
  final bool isSender;
  final List<String>? followUpQuestions;

  Message({
    required this.text,
    required this.isSender,
    this.followUpQuestions,
  });
}

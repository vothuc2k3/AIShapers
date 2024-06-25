class Message {
  final String text;
  final bool isSender;

  Message({required this.text, required this.isSender});
}

class ChatState {
  final List<Message> messages;
  final bool isLoading;
  final String? errorMessage;

  ChatState({required this.messages, this.isLoading = false, this.errorMessage});
}

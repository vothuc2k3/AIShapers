
import 'package:ai_shapers/features/chat/state/suggest_message.dart';

class ChatState {
  final List<Message> messages;
  final bool isLoading;
  final String? errorMessage;

  ChatState({required this.messages, this.isLoading = false, this.errorMessage});
}
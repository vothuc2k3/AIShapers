import 'package:ai_shapers/features/chat/state/suggest_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chat_state.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier()
      : super(ChatState(messages: [], isLoading: false, errorMessage: null));

  void addMessage(Message message) {
    state = ChatState(
        messages: [...state.messages, message],
        isLoading: state.isLoading,
        errorMessage: state.errorMessage);
  }

  void addBotMessage() {
    state = ChatState(
        messages: [...state.messages, Message(text: '', isSender: false)],
        isLoading: state.isLoading,
        errorMessage: state.errorMessage);
  }

  void updateLastMessageContent(String content) {
    final messages = List<Message>.from(state.messages);
    final lastMessage = messages.last;
    if (lastMessage.isSender == false) {
      final updatedMessage = Message(
        text: content,
        isSender: false,
        followUpQuestions: lastMessage.followUpQuestions,
      );
      messages[messages.length - 1] = updatedMessage;
      state = ChatState(
          messages: messages,
          isLoading: state.isLoading,
          errorMessage: state.errorMessage);
    }
  }

  void setLoading(bool isLoading) {
    state = ChatState(
        messages: state.messages,
        isLoading: isLoading,
        errorMessage: state.errorMessage);
  }

  void setError(String? errorMessage) {
    state = ChatState(
        messages: state.messages,
        isLoading: state.isLoading,
        errorMessage: errorMessage);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'chat_state.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(ChatState(messages: []));

  void addMessage(Message message) {
    state = ChatState(
      messages: [...state.messages, message],
      isLoading: state.isLoading,
      errorMessage: state.errorMessage,
    );
  }

  void setLoading(bool isLoading) {
    state = ChatState(
      messages: state.messages,
      isLoading: isLoading,
      errorMessage: state.errorMessage,
    );
  }

  void setError(String errorMessage) {
    state = ChatState(
      messages: state.messages,
      isLoading: false,
      errorMessage: errorMessage,
    );
  }

  void clearError() {
    state = ChatState(
      messages: state.messages,
      isLoading: state.isLoading,
      errorMessage: null,
    );
  }
}

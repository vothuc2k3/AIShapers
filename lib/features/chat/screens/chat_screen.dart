import 'package:ai_shapers/components/chat_bubble.dart';
import 'package:ai_shapers/services/api_chat_service.dart';
import 'package:ai_shapers/state/chat_notifier.dart';
import 'package:ai_shapers/state/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) => ChatNotifier());

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ChatService _chatService = ChatService(
    apiKey: 'pat_ufHwVqLf66a4hEVoC5vTh7NZj0lZ6yTH8QjIM0wXdb5QpNuc4AoVTFjgmiD7nopI',
    apiUrl: 'https://api.coze.com/open_api/v2/chat',
  );
  final String conversationId = '123';  // Sử dụng ID cuộc hội thoại của bạn.

  void _sendMessage(String text) async {
    final chatNotifier = ref.read(chatProvider.notifier);
    chatNotifier.addMessage(Message(text: text, isSender: true));
    chatNotifier.setLoading(true);

    try {
      final response = await _chatService.sendMessage(text, conversationId);
      chatNotifier.addMessage(Message(text: response, isSender: false));
    } catch (e) {
      chatNotifier.setError('Failed to send message: ${e.toString()}');
    } finally {
      chatNotifier.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 194, 194, 194),
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              'Dustin',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 7, 12, 29),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: chatState.messages.length,
                itemBuilder: (context, index) {
                  final message = chatState.messages[index];
                  return ChatBubble(
                    text: message.text,
                    isSender: message.isSender,
                    backgroundColor: message.isSender ? const Color.fromARGB(255, 9, 39, 98) : null,
                    avatar: message.isSender ? null : 'assets/images/avatar.png',
                  );
                },
              ),
            ),
            if (chatState.isLoading)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            if (chatState.errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  chatState.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Message...',
                        filled: true,
                        fillColor: Colors.grey[800],
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      final text = _controller.text.trim();
                      if (text.isNotEmpty) {
                        _sendMessage(text);
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 7, 12, 29),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}

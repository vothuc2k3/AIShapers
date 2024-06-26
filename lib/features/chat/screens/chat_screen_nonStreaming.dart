// import 'package:ai_shapers/components/chat_bubble.dart';
// import 'package:ai_shapers/features/chat/state/chat_notifier.dart';
// import 'package:ai_shapers/features/chat/state/chat_state.dart';
// import 'package:ai_shapers/features/chat/state/suggest_message.dart';
// import 'package:ai_shapers/services/api_non_streaming.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) => ChatNotifier());

// class ChatScreenNonstreaming extends ConsumerStatefulWidget {
//   const ChatScreenNonstreaming({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends ConsumerState<ChatScreenNonstreaming> {
//   final TextEditingController _controller = TextEditingController();
//   final ApiNonStreaming _apiNonStreaming = ApiNonStreaming(
//     apiKey: 'pat_ufHwVqLf66a4hEVoC5vTh7NZj0lZ6yTH8QjIM0wXdb5QpNuc4AoVTFjgmiD7nopI',
//     apiUrl: 'https://api.coze.com/open_api/v2/chat',
//   );
//   final String conversationId = '123';  // Sử dụng ID cuộc hội thoại của bạn.
//   List<String> followUpQuestions = [];  // Lưu trữ các câu hỏi gợi ý từ API

//   void _sendMessage(String text) async {
//     final chatNotifier = ref.read(chatProvider.notifier);
//     chatNotifier.addMessage(Message(text: text, isSender: true));
//     chatNotifier.setLoading(true);
//     followUpQuestions.clear();  // Xóa các câu hỏi gợi ý trước đó

//     try {
//       final response = await _apiNonStreaming.sendMessage(text, conversationId);
//       final messages = response['messages'];
//       if (messages is Iterable) {
//         for (var message in messages) {
//           if (message['type'] == 'answer') {
//             chatNotifier.addMessage(Message(text: message['content'], isSender: false));
//           } else if (message['type'] == 'follow_up') {
//             followUpQuestions.add(message['content']);
//           }
//         }
//       } else {
//         chatNotifier.setError('Failed to parse response: messages is not iterable');
//       }
//     } catch (e) {
//       chatNotifier.setError('Failed to send message: ${e.toString()}');
//     } finally {
//       chatNotifier.setLoading(false);
//     }
//   }

//   void _sendSuggestedMessage(String text) {
//     _controller.text = text;
//     _sendMessage(text);
//     _controller.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final chatState = ref.watch(chatProvider);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 194, 194, 194),
//         title: Row(
//           children: [
//             Image.asset(
//               'assets/images/logo.png',
//               height: 40,
//             ),
//             const SizedBox(width: 10),
//             const Text(
//               'Dustin',
//               style: TextStyle(color: Colors.black, fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         color: const Color.fromARGB(255, 7, 12, 29),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.all(16.0),
//                 itemCount: chatState.messages.length,
//                 itemBuilder: (context, index) {
//                   final message = chatState.messages[index];
//                   return Column(
//                     crossAxisAlignment: message.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                     children: [
//                       ChatBubble(
//                         text: message.text,
//                         isSender: message.isSender,
//                         backgroundColor: message.isSender ? const Color.fromARGB(255, 9, 39, 98) : null,
//                         avatar: message.isSender ? null : 'assets/images/avatar.png',
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             if (followUpQuestions.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Đề xuất:',
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Wrap(
//                         spacing: 8.0,
//                         children: followUpQuestions.map((question) => _buildSuggestedQuestionButton(question)).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             if (chatState.isLoading)
//               const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: CircularProgressIndicator(),
//               ),
//             if (chatState.errorMessage != null)
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   chatState.errorMessage!,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         hintText: 'Message...',
//                         filled: true,
//                         fillColor: Colors.grey[800],
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 20.0),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                           borderSide: BorderSide.none,
//                         ),
//                         hintStyle: const TextStyle(color: Colors.grey),
//                       ),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   IconButton(
//                     icon: const Icon(Icons.send, color: Colors.white),
//                     onPressed: () {
//                       final text = _controller.text.trim();
//                       if (text.isNotEmpty) {
//                         _sendMessage(text);
//                         _controller.clear();
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color.fromARGB(255, 7, 12, 29),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSuggestedQuestionButton(String text) {
//     return ElevatedButton(
//       onPressed: () => _sendSuggestedMessage(text),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color.fromARGB(255, 211, 211, 211).withOpacity(0.4),
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//         textStyle: const TextStyle(fontSize: 14.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
//       ),
//     );
//   }
// }

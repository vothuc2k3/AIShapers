import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color.fromARGB(255, 7, 12, 29);
    const Color chatBubbleColor = Color.fromARGB(255, 9, 39, 98);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 194, 194, 194),
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
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
        color: backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: const [
                  ChatBubble(
                    text: 'This is the main chat template',
                    isSender: true,
                    backgroundColor: chatBubbleColor,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Nov 30, 2023, 9:41 AM',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  ChatBubble(
                    text: 'Oh?',
                    isSender: false,
                  ),
                  ChatBubble(
                    text: 'Cool',
                    isSender: false,
                  ),
                  ChatBubble(
                    text: 'How does it work?',
                    isSender: false,
                  ),
                  ChatBubble(
                    text:
                        'You just edit any text to type in the conversation you want to show, and delete any bubbles you don’t want to use',
                    isSender: true,
                    backgroundColor: chatBubbleColor,
                  ),
                  ChatBubble(
                    text: 'Boom!',
                    isSender: true,
                    backgroundColor: chatBubbleColor,
                  ),
                  ChatBubble(
                    text: 'Hmmm',
                    isSender: false,
                  ),
                  ChatBubble(
                    text: 'I think I get it',
                    isSender: false,
                  ),
                  ChatBubble(
                    text:
                        'Will head to the Help Center if I have more questions tho',
                    isSender: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Message...',
                  filled: true,
                  fillColor: Colors.grey[800],
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(color: Colors.white),
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

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final Color? backgroundColor;

  const ChatBubble(
      {super.key, required this.text, required this.isSender, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: backgroundColor ?? (isSender ? const Color.fromARGB(255, 13,24,61) : const Color.fromARGB(255,233,233,235)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}

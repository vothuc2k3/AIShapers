import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final Color? backgroundColor;
  final String? avatar;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isSender,
    this.backgroundColor,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isSender && avatar != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(avatar!),
              radius: 16,
            ),
          ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              color: backgroundColor ?? (isSender ? const Color.fromARGB(255, 13, 24, 61) : const Color.fromARGB(255, 233, 233, 235)),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isSender ? Colors.white : Colors.black,
                fontSize: 14.0,
                fontFamily: 'Raleway',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

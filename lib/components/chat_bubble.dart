import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatBubble extends ConsumerStatefulWidget {
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
  ChatBubbleState createState() => ChatBubbleState();
}

class ChatBubbleState extends ConsumerState<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!widget.isSender && widget.avatar != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(widget.avatar!),
              radius: 16,
            ),
          ),
        Flexible(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              color: widget.backgroundColor ??
                  (widget.isSender
                      ? const Color.fromARGB(255, 13, 24, 61)
                      : const Color.fromARGB(255, 233, 233, 235)),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.isSender ? Colors.white : Colors.black,
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

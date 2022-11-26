import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  String textMessage;
  bool isMe;
  String userName;
  String userImage;

  MessageBubble({
    Key? key,
    required this.userName,
    required this.textMessage,
    required this.userImage,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // this row makes the bubble to wrap content style
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey.shade400 : Theme.of(context).colorScheme.secondary,
                borderRadius: isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(color: isMe ? Colors.black : Colors.yellow),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  Text(
                    textMessage,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -5,
          right: isMe ? 125 : null,
          left: isMe ? null : 125,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        )
      ],
    );
  }
}

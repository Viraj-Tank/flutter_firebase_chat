import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  String textMessage;
  bool isMe;
  String userName;

  MessageBubble({
    Key? key,
    required this.userName,
    required this.textMessage,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // this row makes the bubble to wrap content style
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Theme
                .of(context)
                .primaryColor : Theme
                .of(context)
                .colorScheme
                .secondary,
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
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
            Text(
            userName,
            style: const TextStyle(color: Colors.yellow),
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
    ),)
    ,
    ]
    ,
    );
  }
}

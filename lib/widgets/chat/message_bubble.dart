import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  String textMessage;
  MessageBubble({Key? key,required this.textMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          child: Text(textMessage,style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}

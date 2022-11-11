import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return Text('Tile Number ${index + 1}');
        },
        itemCount: 10,
      ),
    );
  }
}

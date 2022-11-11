import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/chat_screen.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

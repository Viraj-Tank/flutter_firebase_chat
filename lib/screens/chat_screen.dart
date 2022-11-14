import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
        actions: [
          InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats/fOaXwmQ4o8rHo5siXwBs/messages').snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = (streamSnapshot.data as QuerySnapshot<Map<String, dynamic>>).docs;
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return Text(documents[index]['text']);
            },
            itemCount: documents.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('chats/fOaXwmQ4o8rHo5siXwBs/messages').add({
            'text':'Added from fab button'
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

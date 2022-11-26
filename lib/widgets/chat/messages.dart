import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = (snapshot.data as QuerySnapshot<Map<String, dynamic>>).docs;
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            return MessageBubble(
              key: ValueKey(chatDocs[index].id),
              userName: chatDocs[index]['username'],
              textMessage: chatDocs[index]['text'],
              userImage: chatDocs[index]['userImage'],
              isMe: chatDocs[index]['userId'] == FirebaseAuth.instance.currentUser?.uid,
            );
          },
          itemCount: chatDocs.length,
          reverse: true,
        );
      },
    );
  }
}

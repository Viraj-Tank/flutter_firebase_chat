import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = (snapshot.data as QuerySnapshot<Map<String, dynamic>>).docs;
        return ListView.builder(itemBuilder: (ctx, index) {
          return Text(chatDocs[index]['text'],);
        },itemCount: chatDocs.length,);
      },);
  }
}

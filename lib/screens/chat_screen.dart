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
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return Text('Tile Number ${index + 1}');
        },
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('').snapshots()
              .listen((data) {
            for (var element in data.docs) {
              print('printlog ${element['text']}');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

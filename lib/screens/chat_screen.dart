import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.documents;
          return ListView.builder(
            itemBuilder: (ctx, index) => Container(
              child: Text(documents[index]['text']),
              padding: EdgeInsets.all(8),
            ),
            itemCount: documents.length,
          );
        },
        stream: Firestore.instance
            .collection('chats/4sSxyFxbvthb8AIFdCCs/messages')
            .snapshots(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection('chats/4sSxyFxbvthb8AIFdCCs/messages')
              .add(
            {
              'text': 'This was added ny clicking the button',
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

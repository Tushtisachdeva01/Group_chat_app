import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chat').orderBy('createdAt',descending:true).snapshots(),
      builder: (ctx, chatSnapShot) {
        if (chatSnapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final chatDocs = chatSnapShot.data.documents;
        return ListView.builder(
            itemBuilder: (ctx, index) => Text(
                  chatDocs[index]['text'],
                ),
            reverse: true,
            itemCount: chatDocs.length);
      },
    );
  }
}

import 'package:app_chat_messenger/widgets/message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final documents = chatSnapshot.data.docs;
            return ListView.builder(
                reverse: true,
                itemCount: documents.length,
                itemBuilder: (ctx, index) {
                  final key = documents[index].id;
                  return Container(
                    alignment: Alignment.center,
                    child: MessageCard(
                      documents[index].get('text'),
                      documents[index].get('userId') == user.uid,
                      documents[index].get('userName'),
                      documents[index].get('userImage'),
                      key: ValueKey(key),
                    ),
                  );
                });
          }
        });
  }
}

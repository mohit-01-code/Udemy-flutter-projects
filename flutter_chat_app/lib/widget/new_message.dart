import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(labelText: "Send a Message"),
          )),
          IconButton(onPressed: _sendMessage, icon: const Icon(Icons.send)),
        ],
      ),
    );
  }

  void _sendMessage() {
    final enteredMessage = _messageController.text;
    if (enteredMessage.trim().isEmpty) return;

    _messageController.clear();
    FocusScope.of(context).unfocus(); //to hide keyboard after message send..
    //send to firebase
    final user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection('Chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': user.displayName,
      'userImage': user.photoURL,
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

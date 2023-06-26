import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screen/auth_screen.dart';
import 'package:flutter_chat_app/widget/chat_messages.dart';
import 'package:flutter_chat_app/widget/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xff334e6b),
              Color(0xff121212),
            ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
          ),
          title: Text(
            "Chat screen",
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => const AuthScreen()));
                },
                icon: const Icon(Icons.exit_to_app, color: Color(0xff1ed760))),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff334e6b),
            Color(0xff121212),
          ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
          child: const Column(
            children: [
              Expanded(child: ChatMessages()),
              NewMessage(),
            ],
          ),
        ));
  }
}

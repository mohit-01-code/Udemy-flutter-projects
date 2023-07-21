import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/utils/constants.dart';
import 'package:flutter_chat_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  final utils = Utils();
  http.Response? response;
  bool isSending = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            style: TextStyle(color: Theme.of(context).colorScheme.background),
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Send a Message",
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.background)),
          )),
          isSending
              ? const CircularProgressIndicator(
                  color: GREEN_COLOR,
                  strokeWidth: 2.0,
                )
              : IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send,
                      color: Theme.of(context).colorScheme.background),
                ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    final enteredMessage = _messageController.text;
    if (enteredMessage.trim().isEmpty) return;
    setIsSending(true);

    String content = await checkSentiments(enteredMessage);
    if (content == "internet") {
      utils.showToast("Connect to Internet");
      setIsSending(false);
      return;
    } else if (content == "error") {
      final errorResponse = jsonDecode(response!.body);
      final errorMsg = errorResponse["error"]["message"];
      utils.showCustomDialog(context, "Sentiments Analysis Error", errorMsg);
      setIsSending(false);
      return;
    } else if (content == "negative") {
      utils.showCustomDialog(context, "Sentiment Message Alert",
          "Message must not contain sentiment words");
      setIsSending(false);
      return;
    }

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
    setIsSending(false);
  }

  Future<String> checkSentiments(String message) async {
    String apiKey =
        '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'; // Replace with your API key
    const apiUrl = 'https://api.openai.com/v1/chat/completions';
    final headers = {
      'Authorization': 'Bearer $apiKey', // Replace with your actual API key
      'Content-Type': 'application/json',
    };
    final data = {
      'model': 'gpt-3.5-turbo',
      'messages': [
        {
          'role': 'system',
          'content':
              'You will be provided with a tweet, and your task is to classify its sentiment as positive, neutral, or negative.'
        },
        {'role': 'user', 'content': message},
      ],
      'temperature': 0,
      'max_tokens': 256,
    };
    try {
      response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: jsonEncode(data));
      log("CHECK_SENTIMENTS ::: response : ${response!.body}",
          name: "new_message");
      if (response!.statusCode == 200) {
        final jsonResponse = jsonDecode(response!.body);
        return jsonResponse['choices'][0]['message']['content'];
      } else {
        return 'error';
      }
    } catch (e) {
      return 'internet';
    }
  }

  void setIsSending(bool param) {
    setState(() {
      isSending = param;
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

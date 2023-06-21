import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screen/auth_screen.dart';
import 'package:flutter_chat_app/screen/chat_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? _user;
  Widget? content;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();

    if (_user != null) {
      log("splash_screen : User Exist");
      content = const ChatScreen();
    } else {
      log("splash_screen : User is null");
      content = const AuthScreen();
    }

    Timer(
      const Duration(seconds: 1), // Set the duration for the splash screen
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              content!, // Replace HomeScreen with your main screen widget
        ),
      ),
    );
  }

  Future<void> getCurrentUser() async {
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff334e6b),
          Color(0xff121212),
        ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 150),
              Image.asset('assets/images/chat-app-logo.png'),
              Image.asset('assets/images/slogan-logo.png'),
            ],
          ),
        ),
      ),
    );
  }
}

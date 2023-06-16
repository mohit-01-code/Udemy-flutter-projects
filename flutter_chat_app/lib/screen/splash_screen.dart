import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screen/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 1), // Set the duration for the splash screen
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const AuthScreen(), // Replace HomeScreen with your main screen widget
        ),
      ),
    );
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

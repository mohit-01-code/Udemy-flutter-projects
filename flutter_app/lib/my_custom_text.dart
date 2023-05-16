import 'package:flutter/material.dart';

class MyCustomText extends StatelessWidget {
  // MyCustomText(String greetText, {super.key}) : text = greetText;
  const MyCustomText(this.greetText, {super.key});
  final String greetText;

  @override
  Widget build(context) {
    return Text(
      greetText,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}

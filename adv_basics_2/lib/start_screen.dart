import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          'assets/images/quiz-logo.png',
          width: 300,
          color: Color.fromARGB(200, 255, 255, 255),
        ),
        const SizedBox(
          height: 70,
        ),
        const Text(
          'Learn Flutter the fun way!',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: startQuiz ,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          icon: Icon(Icons.arrow_right_alt),
          label: const Text(
            'Start Quiz',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
      ]),
    );
  }
}

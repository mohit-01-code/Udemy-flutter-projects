import 'package:adv_basics_2/data/questions.dart';
import 'package:adv_basics_2/questions_screen.dart';
import 'package:adv_basics_2/result_screen.dart';
import 'package:adv_basics_2/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen';
  List<String> selectedOption = [];

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void restartQuiz() {
    selectedOption = [];
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void onOptionSelect(String option) {
    selectedOption.add(option);
    print(selectedOption[selectedOption.length - 1]);
    if (selectedOption.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  @override
  Widget build(context) {
    Widget activeWidget = StartScreen(switchScreen);
    if (activeScreen == 'question-screen') {
      activeWidget = QuestionScreen(selectOption: onOptionSelect);
    } else if (activeScreen == 'result-screen') {
      activeWidget = ResultScreen(
        chosenOptions: selectedOption,
        restartQuiz: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFe9e9e9),
        body: activeWidget,
      ),
    );
  }
}

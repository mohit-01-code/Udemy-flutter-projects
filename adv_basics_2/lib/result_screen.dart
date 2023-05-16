import 'package:adv_basics_2/data/questions.dart';
import 'package:adv_basics_2/result_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.chosenOptions, required this.restartQuiz});

  final List<String> chosenOptions;
  final void Function() restartQuiz;

  List<Map<String, Object>> getSummaryData() {
    List<Map<String, Object>> summaryData = [];
    print(chosenOptions.length);
    for (var i = 0; i < chosenOptions.length; i++) {
      summaryData.add({
        'index': i,
        'question': questions[i].question,
        'correct_answer': questions[i].options[0],
        'user_answer': chosenOptions[i],
      });
    }
    return summaryData;
  }

  @override
  Widget build(context) {
    final numTotalQuestion = questions.length;
    final numCorrectAnswer = getSummaryData()
        .where((element) => element['correct_answer'] == element['user_answer'])
        .length;

    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You have answered ${numCorrectAnswer} correct answers out of ${numTotalQuestion} questions',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(height: 30),
          ResultSummary(getSummaryData()),
          SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: restartQuiz,
            icon: Icon(Icons.restart_alt),
            label: Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}

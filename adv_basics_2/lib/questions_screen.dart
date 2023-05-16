import 'package:adv_basics_2/data/questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'option_button.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.selectOption});

  final void Function(String selectedOption) selectOption;

  @override
  State<QuestionScreen> createState() {
    return _QuestionState();
  }
}

class _QuestionState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  void switchQuestion(String option){
    widget.selectOption(option);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            currentQuestion.question,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 22
            )),
          SizedBox(
            height: 30,
          ),
          //... is used for spreading values
          ...currentQuestion.getShuffledOptions().map((option) {
            return OptionButton(optionText: option, onTap: (){
              switchQuestion(option);
            });
          })
        ],
      ),
    );
  }
}

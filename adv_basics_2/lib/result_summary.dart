import 'package:flutter/material.dart';

class ResultSummary extends StatelessWidget {
  ResultSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            var isCorrect = data['user_answer'] == data['correct_answer'];
            return Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                        radius: 12,
                        backgroundColor: isCorrect?Colors.green:Colors.red,
                        child: Text(
                          ((data['index'] as int) + 1).toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['question'].toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(data['user_answer'].toString(), style: TextStyle(color: isCorrect ?Colors.green:Colors.red),),
                        Text(data['correct_answer'].toString(), style: TextStyle(color: Colors.green),),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

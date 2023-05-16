import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
      useMaterial3: true,
      cardTheme: CardTheme(
        elevation: 13,
        color: Color(0xfff1f0f5),
      ),
    ),
    home: Expenses(),
  ));
}

//start color hex 35fdfd
//end color hex #40d0fb
//card bottom color dddddd
//card top color ecf1ef

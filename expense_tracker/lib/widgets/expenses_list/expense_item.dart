import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(context) {
    return Card(
      child: Column(
        children: [
          Text(expense.title),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("\$${expense.amount.toStringAsFixed(2)}"),
                Spacer(),
                Row(
                  children: [
                    Icon(CategoryIcons[expense.category]),
                    Text(expense.formattedDate),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

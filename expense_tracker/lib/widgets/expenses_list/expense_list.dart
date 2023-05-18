import 'dart:developer';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  @override
  Widget build(context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              ),
            ),
            onDismissed: (direction) {
              log("Removing Expense ::: ${expenses[index]}");
              onRemoveExpense(expenses[index]);
            },
            key: UniqueKey(),
            child: ExpenseItem(expense: expenses[index]));
      },
      itemCount: expenses.length,
    );
  }
}

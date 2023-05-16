import 'dart:developer';

import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  @override
  Widget build(context) {
    return Container(
      height: 100,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Dismissible(
              onDismissed: (dismiss) {
                log("Removing Expense ::: ${expenses[index]}");
                onRemoveExpense(expenses[index]);
              },
              key: ValueKey(expenses[index].id),
              child: ExpenseItem(expense: expenses[index]));
        },
        itemCount: expenses.length,
      ),
    );
  }
}

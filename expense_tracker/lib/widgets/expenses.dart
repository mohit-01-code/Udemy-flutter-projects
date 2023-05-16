import 'dart:developer';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_list.dart';
import 'package:flutter/material.dart';

import 'new_expense.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];
  Widget mainContent =
      const Center(child: Text('No Expenses found. Please add new expense.'));

  @override
  void initState() {
    // TODO: implement initState
    log("All Expenses ::: ${_registeredExpenses.toString()}");
    super.initState();
  }

  Future<void> _refresh() async {
    // Your code to refresh the widget
    setState(() {
      log("All Expenses ::: ${_registeredExpenses.toString()}");
    });
  }

  @override
  Widget build(context) {
    if (_registeredExpenses.isNotEmpty)
      mainContent = ExpenseList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF40d0fb), Color(0xFF35fdfd)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: Text('Expense Tracker'),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF35fdfd), Color(0xFF40d0fb)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Text('the banner'),
              Expanded(child: mainContent),
            ],
          ),
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(addNewExpense: _addNewExpense));
  }

  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      print("Removing expense ::: ${expense.toString()}");
      print("Index of expense while removing ::: $expenseIndex");
      _registeredExpenses.removeAt(expenseIndex);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            print("Undo Click for ${expense.toString()}");
            print("Index ::: $expenseIndex");
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }
}

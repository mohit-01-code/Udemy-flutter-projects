import 'dart:developer';

import 'package:expense_tracker/manage_expense.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
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
  List<Expense> _registeredExpenses = [];
  Widget mainContent =
      const Center(child: Text('No Expenses found. Please add new expense.'));

  @override
  initState() {
    // TODO: implement initState
    log("All Expenses ::: ${_registeredExpenses.toString()}");
    setExpenses();
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
    if (_registeredExpenses.isNotEmpty) {
      log("Registered expense is not empty setting main content");
      mainContent = ExpenseList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Expense Tracker'),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
          ],
        ),
        body: Column(
          children: [
            Chart(expenses: _registeredExpenses),
            Expanded(child: mainContent),
          ],
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

  Future<void> _addNewExpense(Expense expense) async {
    setState(() {
      _registeredExpenses.add(expense);
    });
    await ManageExpense().saveExpenseList(_registeredExpenses);
  }

  Future<void> _removeExpense(Expense expense) async {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.removeAt(expenseIndex);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleting...'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
              ManageExpense().saveExpenseList(_registeredExpenses);
            });
          },
        ),
      ),
    );
    await ManageExpense().saveExpenseList(_registeredExpenses);
  }

  Future<void> setExpenses() async {
    _registeredExpenses = await ManageExpense().getExpenseList();
    setState(() {});
    log("Shared prefs expenses ::: ${_registeredExpenses.toString()}");
  }
}

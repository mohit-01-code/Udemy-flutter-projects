import 'dart:developer';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('dd/MM/yyyy');

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addNewExpense});

  final Future<void> Function(Expense newExpense) addNewExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory = Category.leisure;
  Expense? newExpense;

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text('title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: "\$ ",
                    label: Text("Amount"),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null
                        ? "No Date Selected"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: selectDate,
                        icon: Icon(Icons.calendar_month)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              ElevatedButton(
                onPressed: () {
                  log(_titleController.text.trim());
                  _submitExpenseData();
                },
                child: Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    if (_amountController.text.trim().isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Invalid Input'),
              content:
                  Text('PLease make sure amount or title is entered Correctly'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text('Ok'))
              ],
            );
          });
    } else {
      newExpense = Expense(
          title: _titleController.text.trim(),
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory!);
      log("Adding Expense ::: $newExpense");
      addExpense(newExpense);
      Navigator.pop(context);
    }
  }

  Future<void> selectDate() async {
    final initialDate = DateTime.now();
    final firstDate =
        DateTime(initialDate.year - 1, initialDate.month, initialDate.day);
    final lastDate =
        DateTime(initialDate.year + 1, initialDate.month, initialDate.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  Future<void> addExpense(Expense? newExpense) async {
    await widget.addNewExpense(newExpense!);
  }
}

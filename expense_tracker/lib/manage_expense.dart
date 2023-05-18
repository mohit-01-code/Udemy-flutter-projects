import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/expense.dart';

class ManageExpense {
  final key = 'EXPENSE_LIST_KEY';

  Future<void> saveExpenseList(List<Expense> expenses) async {
    final expensePrefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        expenses.map((e) => e.toJson()).toList();
    final String jsonString = jsonEncode(jsonList);
    await expensePrefs.setString(key, jsonString);
  }

  Future<List<Expense>> getExpenseList() async {
    final expensePrefs = await SharedPreferences.getInstance();

    final String? jsonString = expensePrefs.getString(key);
    if (jsonString != null) {
      final List<dynamic> mapList = jsonDecode(jsonString) as List<dynamic>;
      final List<Expense> expenses =
          mapList.map((e) => Expense.fromJson(e)).toList();
      return expenses;
    }
    return [];
  }
}

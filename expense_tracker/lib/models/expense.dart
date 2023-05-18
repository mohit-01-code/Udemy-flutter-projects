import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat('dd/MM/yyyy');

enum Category { food, travel, leisure, work }

const CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  String? id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.toString().split('.').last,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    Expense expense = Expense(
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: Category.values.firstWhere((category) =>
          category.toString().split('.').last == json['category']),
    );
    expense.id = json['id'];
    return expense;
  }

  @override
  String toString() {
    return "{id: $id, "
        "title: $title, "
        "amount: ${amount.toString()}, "
        "Date-Time: $formattedDate, "
        "Category: ${category.name}}";
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}

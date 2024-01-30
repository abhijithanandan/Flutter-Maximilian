import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Category { food, travel, leisure, work }

final formatter = DateFormat.yMd();

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate => formatter.format(date);

  Expense({
    required this.category,
    required this.title,
    required this.amount,
    required this.date,
  }) : id = const Uuid().v4();
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  /// Add only expnses that are of the same category while creating a new bucket
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}

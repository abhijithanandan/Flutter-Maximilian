import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesTrackerApp extends StatefulWidget {
  const ExpensesTrackerApp({super.key});

  @override
  State<ExpensesTrackerApp> createState() => _ExpensesTrackerAppState();
}

class _ExpensesTrackerAppState extends State<ExpensesTrackerApp> {
  final List<Expense> _registeredExpenses = [
    Expense(
      category: Category.food,
      title: "Groceries",
      amount: 50.0,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.travel,
      title: "Taxi",
      amount: 20.0,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.leisure,
      title: "Cinema",
      amount: 15.0,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.work,
      title: "Lunch",
      amount: 15.0,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expenses Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Column(
            children: [
              const Text("The chart"),
              Expanded(
                child: ExpenseList(expenses: _registeredExpenses),
              ),
            ],
          ),
        ));
  }
}

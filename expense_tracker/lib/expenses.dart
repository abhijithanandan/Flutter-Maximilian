import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (cxt) => const NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("The chart"),
          Expanded(
            child: ExpenseList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}

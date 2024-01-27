import 'package:flutter/material.dart';

class ExpensesTrackerApp extends StatefulWidget {
  const ExpensesTrackerApp({super.key});

  @override
  State<ExpensesTrackerApp> createState() => _ExpensesTrackerAppState();
}

class _ExpensesTrackerAppState extends State<ExpensesTrackerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expenses Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(
          body: Column(
            children: [
              Text("The chart"),
              Text("Expense list ..."),
            ],
          ),
        ));
  }
}

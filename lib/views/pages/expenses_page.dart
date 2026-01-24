import 'package:flutter/material.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(children: [
            Text("Expense")
          ]),
        ),
      ),
    );
  }
}

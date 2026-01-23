import 'package:flutter/material.dart';
import 'package:habit_wallet_lite/views/pages/new_transaction_page.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(children: []),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewTransactionPage()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

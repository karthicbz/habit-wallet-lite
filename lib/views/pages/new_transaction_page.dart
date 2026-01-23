import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/data/providers/transaction_provider.dart';

class NewTransactionPage extends ConsumerWidget {
  const NewTransactionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TransactionModel transactionModel = ref.watch(transactionProvider);
    TransactionNotifier transactionNotifier = ref.read(transactionProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
        title: Text(
          addTransactionText,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Save", style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Divider(color: Theme.of(context).dividerColor),
                SegmentedButton(
                  segments: <ButtonSegment<Transaction>>[
                    ButtonSegment(
                      value: Transaction.expense,
                      label: Text("Expense"),
                    ),
                    ButtonSegment(
                      value: Transaction.income,
                      label: Text("Income"),
                    ),
                  ],
                  selected: {transactionModel.transactionType},
                  onSelectionChanged: (newSelection){
                    // print(newSelection);
                    transactionNotifier.updateTransactionType(newSelection);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

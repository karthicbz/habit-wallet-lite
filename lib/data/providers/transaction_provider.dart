import 'package:flutter/material.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'transaction_provider.g.dart';

@riverpod
class TransactionNotifier extends _$TransactionNotifier {
  @override
  TransactionModel build() {
    return TransactionModel(
      id: Uuid().v1().toString(),
      remoteId: null,
      transactionType: Transaction.expense,
      category: Category.others,
      amount: 0.0,
      transactionDate: DateTime.now(),
      notes: null,
      files: null,
      isEditedLocally: true,
      updatedAt: DateTime.now(),
      syncedAt: null,
    );
  }

  void updateTransactionType(Set<Transaction?> transaction) {
    state = state.copyWith(transactionType: transaction.first);
  }

  Future<void> updateTransactionDate(
    BuildContext context,
    TextEditingController transactionDate,
  ) async {
    final today = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(2000),
      lastDate: today,
    );
    String formattedDate = DateFormat('MMM dd, yyyy').format(selectedDate!);
    transactionDate.value = TextEditingValue(text: formattedDate);
    state = state.copyWith(transactionDate: selectedDate);
  }

  void updateCategory(
    BuildContext context,
    TextEditingController categoryController,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Choose Category"),
        content: SizedBox(
          width: 400,
          height: 300,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: Category.values.length,
            itemBuilder: (context, index) => GestureDetector(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Category.values[index].name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              onTap: () {
                state = state.copyWith(category: Category.values[index]);
                categoryController.value = TextEditingValue(
                  text: Category.values[index].name,
                );
                Navigator.pop(context);
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}

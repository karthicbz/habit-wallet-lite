import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:habit_wallet_lite/data/constants/AppHelper.dart';
import 'package:habit_wallet_lite/data/constants/hive_boxes.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../l10n/app_localizations.dart';

part 'transaction_provider.g.dart';

@riverpod
class TransactionNotifier extends _$TransactionNotifier {
  late Box<TransactionModel> _transactions;

  @override
  TransactionModel build() {
    _transactions = Hive.box(transactionBox);

    print(_transactions.values.toList()[1].transactionDate);
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

  //clicking on transaction list item takes user to edit transaction page
  //and based on the id sent from transaction page here I am filtering it
  //and updating the state for modification
  void loadTransactionForEdit(
    String id,
    TextEditingController amountController,
    TextEditingController notesController,
    TextEditingController dateController,
    TextEditingController categoryController,
  ) {
    TransactionModel model = _transactions.values
        .where((t) => t.id == id)
        .first;
    amountController.value = TextEditingValue(text: model.amount.toString());
    notesController.value = TextEditingValue(text: model.notes ?? "");
    dateController.value = TextEditingValue(
      text: DateFormat('MMM dd, yyyy').format(model.transactionDate!),
    );
    categoryController.value = TextEditingValue(
      text: model.category?.name ?? Category.others.name,
    );
    state = model;
  }

  void updateTransactionType(Set<Transaction?> transaction) {
    state = state.copyWith(transactionType: transaction.first);
  }

  // void updateAmountAndNotes(TextEditingController amountController, TextEditingController notesController){
  //   amountController.value = TextEditingValue(text: state.amount.toString());
  //   notesController.value = TextEditingValue(text: state.notes??"");
  // }

  Future<void> showFilePicker()async{
    await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
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
        title: Text(AppLocalizations.of(context)!.categoryText),
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

                    AppHelper().convertEnumToString(Category.values[index], context),
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

  void saveTransaction(String amount, String notes, String? id) {
    // print(state.transactionType);
    //if id is not there then it's a new update
    print("id: $id");
    if (id == null) {
      print("I am inside null");
      state = state.copyWith(notes: notes, amount: double.parse(amount));
      _transactions.add(state);
    } else {
      print("I am not inside null");
      //if id is there then it's an edit
      state = state.copyWith(
        notes: notes,
        amount: double.parse(amount),
        isEditedLocally: true,
        updatedAt: DateTime.now(),
      );
      List<TransactionModel> models = _transactions.values
          .where((t) => t.id != id)
          .toList();
      for (int i = 0; i < _transactions.length; i++) {
        if (_transactions.values.toList()[i].id == id) {
          _transactions.deleteAt(i);
          break;
        }
      }
      _transactions.add(state);
      // _transactions.addAll(models);
    }
  }
}

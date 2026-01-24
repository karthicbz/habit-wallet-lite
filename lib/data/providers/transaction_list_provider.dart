import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../constants/hive_boxes.dart';

part 'transaction_list_provider.g.dart';

@riverpod
class TransactionListNotifier extends _$TransactionListNotifier {
  late Box<bool> _transactionLoadStatus;
  late Box<TransactionModel> _transactionModel;

  @override
  List<TransactionModel> build() {
    _transactionLoadStatus = Hive.box(transactionStatusBox);
    _transactionModel = Hive.box(transactionBox);
    // loadJsonFromFile();
    return [];
  }

  void loadJsonFromFile() async {
    // print("transactionStatus: ${transactionLoadStatus.values}");
    if (_transactionLoadStatus.values.isEmpty) {
      _transactionLoadStatus.put("jsonLoaded", false);
    }
    if (_transactionLoadStatus.values.first == false) {
      final jsonString = await rootBundle.loadString(
        'assets/transactions.json',
      );
      final data = jsonDecode(jsonString);
      print("data: $data");
      // List<TransactionModel> transactionModel = [];
      List<dynamic> transactions =
          data["BARB0KIMXXX"][0]["decrypted_data"]["Account"]["Transactions"]["Transaction"];
      for (var t in transactions) {
        _transactionModel.add(
          TransactionModel(
            id: Uuid().v1(),
            remoteId: t["narration"],
            transactionType: (t["type"] == "DEBIT")
                ? Transaction.expense
                : Transaction.income,
            category: null,
            amount: double.parse(t["amount"]),
            transactionDate: DateTime.parse(t["transactionTimestamp"]),
            notes: null,
            files: [],
            isEditedLocally: false,
            updatedAt: DateTime.now(),
            syncedAt: null
          ),
        );
      }

      // print(transactionModel[0].amount);
      // state = transactionModel;
      _transactionLoadStatus.put("jsonLoaded", true);
    }
  }
}

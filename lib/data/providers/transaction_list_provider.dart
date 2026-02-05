import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../constants/hive_boxes.dart';

part 'transaction_list_provider.g.dart';

class TransactionListHelper {
  final List<TransactionModel> transactionModel;
  final bool isLoading;
  final List<TransactionModel> dummyTransactionModel;

  const TransactionListHelper({
    required this.transactionModel,
    required this.isLoading,
    required this.dummyTransactionModel,
  });

  TransactionListHelper copyWith({
    List<TransactionModel>? transactionModel,
    bool? isLoading,
    List<TransactionModel>? dummyTransactionModel,
  }) {
    return TransactionListHelper(
      transactionModel: transactionModel ?? this.transactionModel,
      isLoading: isLoading ?? this.isLoading,
      dummyTransactionModel:
          dummyTransactionModel ?? this.dummyTransactionModel,
    );
  }
}

@Riverpod(keepAlive: true)
class TransactionListNotifier extends _$TransactionListNotifier {
  late Box<bool> _transactionLoadStatus;
  late Box<TransactionModel> _transactionModel;

  @override
  TransactionListHelper build() {
    _transactionLoadStatus = Hive.box(transactionStatusBox);
    _transactionModel = Hive.box(transactionBox);
    // // loadJsonFromFile();
    // return [];
    // loadJsonFromFile();
    if (_transactionModel.isNotEmpty) {
      final sorted = _transactionModel.values.toList()
        ..sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      return TransactionListHelper(
        transactionModel: [...sorted],
        dummyTransactionModel: [..._transactionModel.values],
        isLoading: false,
      );
    } else {
      return TransactionListHelper(
        transactionModel: [],
        isLoading: false,
        dummyTransactionModel: [],
      );
    }
  }

  void searchTransaction(String text) async {
    if (text.isEmpty) {
      final sorted = state.dummyTransactionModel
        ..sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      state = state.copyWith(transactionModel: [...sorted]);
    } else {
      List<TransactionModel> transactions = state.dummyTransactionModel
          .where(
            (t) =>
                (t.amount.toString().contains(text) ||
                t.category!.name.toLowerCase().contains(text) ||
                t.notes!.toLowerCase().contains(text)),
          )
          .toList();

      state = state.copyWith(transactionModel: [...transactions]);
    }
  }

  // Future<void> loadJsonFromFile() async {
  //   // print("transactionStatus: ${transactionLoadStatus.values}");
  //   state = state.copyWith(isLoading: true);
  //   if (_transactionLoadStatus.values.isEmpty) {
  //     _transactionLoadStatus.put("jsonLoaded", false);
  //   }
  //   if (_transactionLoadStatus.values.first == false) {
  //     final jsonString = await rootBundle.loadString(
  //       'assets/transactions.json',
  //     );
  //     final data = jsonDecode(jsonString);
  //     // print("data: $data");
  //     List<TransactionModel> transactionModel = [];
  //     List<dynamic> transactions =
  //         data["BARB0KIMXXX"][0]["decrypted_data"]["Account"]["Transactions"]["Transaction"];
  //     for (var t in transactions) {
  //       transactionModel.add(
  //         TransactionModel(
  //           id: Uuid().v1(),
  //           remoteId: t["narration"],
  //           transactionType: (t["type"] == "DEBIT")
  //               ? Transaction.expense
  //               : Transaction.income,
  //           category: Category.others,
  //           amount: double.parse(t["amount"]),
  //           transactionDate: DateTime.parse(t["transactionTimestamp"]),
  //           notes: null,
  //           files: [],
  //           isEditedLocally: false,
  //           updatedAt: DateTime.now(),
  //           syncedAt: null,
  //         ),
  //       );
  //     }

  //     // print(transactionModel[0].amount);
  //     // state = transactionModel;
  //     _transactionLoadStatus.put("jsonLoaded", true);
  //     _transactionModel.addAll(transactionModel);
  //     state = state.copyWith(
  //       transactionModel: transactionModel,
  //       dummyTransactionModel: transactionModel,
  //     );
  //   }
  //   state = state.copyWith(isLoading: false);
  // }
}

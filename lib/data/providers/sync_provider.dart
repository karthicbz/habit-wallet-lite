import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:habit_wallet_lite/data/constants/hive_boxes.dart';
import 'package:habit_wallet_lite/data/models/sync_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_provider.g.dart';

@riverpod
class SyncNotifier extends _$SyncNotifier {
  String syncPath = dotenv.env['SYNC_ENDPOINT']!;
  late Box<TransactionModel> _transactionModel;
  late Box<SyncModel> syncModelBox;

  @override
  SyncModel build() {
    syncModelBox = Hive.box(syncBox);
    _transactionModel = Hive.box(transactionBox);
    if (syncModelBox.isEmpty) {
      return SyncModel(lastSynced: DateTime.now(), isSyncing: false);
    } else {
      return syncModelBox.values.first;
    }
  }

  Future<bool> syncTransaction() async {
    // print(syncPath);
    state = state.copyWith(isSyncing: true);
    List<TransactionModel> response = await getTransactions();
    List<TransactionModel> newTransactions = response
        .where((r) => !_transactionModel.values.contains(r))
        .toList();
    if (newTransactions.isNotEmpty) {
      // print("Resp is not empty");
      _transactionModel.addAll([...newTransactions]);
    }
    await postTransactions();

    state = state.copyWith(lastSynced: DateTime.now(), isSyncing: false);
    syncModelBox.clear();
    syncModelBox.add(state);
    return true;
  }

  Future<List<TransactionModel>> getTransactions() async {
    await Future.delayed(Duration(milliseconds: 500));
    return [];
  }

  Future<void> postTransactions() async {
    // List<TransactionModel> newTransactions = [];
    for (int i = 0; i < _transactionModel.length; i++) {
      TransactionModel transaction = _transactionModel.values.toList()[i];
      if(transaction.isEditedLocally == true) {
        _transactionModel.putAt(i,
            _transactionModel.values.toList()[i].copyWith(
                isEditedLocally: false));
      }
    }
  }
}

import 'package:habit_wallet_lite/data/models/transaction_model.dart';
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

  void updateTransactionType(Set<Transaction?> transaction){
    state = state.copyWith(transactionType: transaction.first);
  }
}

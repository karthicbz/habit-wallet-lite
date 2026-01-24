import 'package:habit_wallet_lite/data/models/transaction_category_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_category_provider.g.dart';

@riverpod
class TransactionCategoryNotifier extends _$TransactionCategoryNotifier {
  @override
  List<TransactionCategoryModel> build() {
    List<TransactionCategoryModel> transactionCategoryModel = [];
    for (var c in Category.values) {
      transactionCategoryModel.add(
        TransactionCategoryModel(category: c, limit: 0, spent: 0),
      );
    }
    return transactionCategoryModel;
  }
}

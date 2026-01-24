

import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:hive_ce_flutter/adapters.dart';

class TransactionCategoryModel extends HiveObject{
  final Category category;
  final double limit;
  final double spent;

  TransactionCategoryModel({
    required this.category,
    required this.limit,
    required this.spent,
  });

  TransactionCategoryModel copyWith({
    Category? category,
    double? limit,
    double? spent,
  }) {
    return TransactionCategoryModel(
      category: category ?? this.category,
      limit: limit ?? this.limit,
      spent: spent ?? this.spent,
    );
  }
}

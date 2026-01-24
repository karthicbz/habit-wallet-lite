import 'package:flutter/material.dart';
import 'package:habit_wallet_lite/data/constants/hive_boxes.dart';
import 'package:habit_wallet_lite/data/models/transaction_category_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/views/widgets/custom_page_route.dart';
import 'package:habit_wallet_lite/views/widgets/custom_textfield.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_category_provider.g.dart';

@riverpod
class TransactionCategoryNotifier extends _$TransactionCategoryNotifier {
  late Box<TransactionModel> _transactionModel;
  late Box<TransactionCategoryModel> _tcModel;

  @override
  List<TransactionCategoryModel> build() {
    _transactionModel = Hive.box(transactionBox);
    _tcModel = Hive.box(transactionCategoryBox);

    _seedCategoriesIfEmpty();

    final List<TransactionCategoryModel> result = [];

    for (final c in Category.values) {
      double spent = 0.0;

      for (final t in _transactionModel.values) {
        if (
        t.category?.name == c.name &&
            t.transactionType == Transaction.expense
        ) {
          spent += t.amount ?? 0.0;
        }
      }

      final stored = _tcModel.values
          .where((e) => e.category == c)
          .cast<TransactionCategoryModel?>()
          .firstOrNull;

      result.add(
        TransactionCategoryModel(
          category: c,
          limit: stored?.limit ?? 0.0,
          spent: spent,
        ),
      );
    }

    return result;
  }

  void _seedCategoriesIfEmpty() {
    if (_tcModel.isNotEmpty) return;

    final initial = Category.values
        .map(
          (c) => TransactionCategoryModel(
        category: c,
        limit: 0.0,
        spent: 0.0,
      ),
    )
        .toList();

    _tcModel.addAll(initial);
  }

  void updateSpent(Category c, BuildContext context) {
    final TextEditingController spentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Spent Limit"),
        content: CustomTextField(
          textEditingController: spentController,
          label: "Spent Limit",
          isPassword: false,
          textInputType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final newLimit =
                  double.tryParse(spentController.text) ?? 0.0;

              for (int i = 0; i < _tcModel.length; i++) {
                final tc = _tcModel.getAt(i);
                if (tc?.category == c) {
                  _tcModel.putAt(
                    i,
                    TransactionCategoryModel(
                      category: c,
                      limit: newLimit,
                      spent: tc!.spent,
                    ),
                  );
                  break;
                }
              }
              state = build();

              CustomPageRoute(context: context).pop();
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
}

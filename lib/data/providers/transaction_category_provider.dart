import 'dart:ffi';

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

  @override
  List<TransactionCategoryModel> build() {
    _transactionModel = Hive.box(transactionBox);
    List<TransactionCategoryModel> transactionCategoryModel = [];
    for (var c in Category.values) {
      double spent = 0.0;
      for (var t in _transactionModel.values) {
        // print("${t.category?.name} - ${c.name}");
        if (t.category?.name == c.name) {
          if (t.transactionType == Transaction.expense) {
            spent += t.amount ?? 0.0;
          }
        }
      }
      transactionCategoryModel.add(
        TransactionCategoryModel(category: c, limit: 0, spent: spent),
      );
    }
    return transactionCategoryModel;
  }

  void updateSpent(Category c, BuildContext context) {
    TextEditingController spentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Spent Limit"),
        content: CustomTextField(
          textEditingController: spentController,
          label: "Spent Limit",
          isPassword: false,
          textInputType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              List<TransactionCategoryModel> newTCategoryModel = [];
              for (int i = 0; i < state.length; i++) {
                if (state[i].category == c) {
                  newTCategoryModel.add(
                    TransactionCategoryModel(
                      category: c,
                      limit: double.parse(spentController.text),
                      spent: state[i].spent,
                    ),
                  );
                } else {
                  newTCategoryModel.add(
                    TransactionCategoryModel(
                      category: state[i].category,
                      limit: state[i].limit,
                      spent: state[i].spent,
                    ),
                  );
                }
              }
              state = newTCategoryModel;
              CustomPageRoute(context: context).pop();
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}

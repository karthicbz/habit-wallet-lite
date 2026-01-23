import 'dart:typed_data';

import 'package:hive_ce_flutter/adapters.dart';

enum Transaction { income, expense }

enum Category {
  foodAndGroceries,
  transport,
  shopping,
  utilities,
  medicine,
  education,
  others,
}

class TransactionModel extends HiveObject {
  final Transaction transaction;
  final Category category;
  final double amount;
  final DateTime date;
  final String notes;
  final List<Uint8List> files;
  final String remoteId;
  final bool isEditedLocally;
  final DateTime updatedAt;
  final DateTime syncedAt;

  TransactionModel({
    required this.transaction,
    required this.category,
    required this.amount,
    required this.date,
    required this.notes,
    required this.files,
    required this.remoteId,
    required this.isEditedLocally,
    required this.updatedAt,
    required this.syncedAt,
  });

  TransactionModel copyWith({
    Transaction? transaction,
    Category? category,
    double? amount,
    DateTime? date,
    String? notes,
    List<Uint8List>? files,
    String? remoteId,
    bool? isEditedLocally,
    DateTime? updatedAt,
    DateTime? syncedAt,
  }) {
    return TransactionModel(
      transaction: transaction ?? this.transaction,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      files: files ?? this.files,
      remoteId: remoteId ?? this.remoteId,
      isEditedLocally: isEditedLocally ?? this.isEditedLocally,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }
}

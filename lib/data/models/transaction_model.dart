import 'dart:typed_data';

import 'package:hive_ce_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

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
  final String id;
  final String remoteId;

  final String transactionType;
  final Category category;
  final double amount;
  final DateTime transactionTime;

  final String notes;
  final List<Uint8List> files;

  final bool isEditedLocally;
  final DateTime updatedAt;
  final DateTime syncedAt;

  TransactionModel({
    required this.id,
    required this.remoteId,
    required this.transactionType,
    required this.category,
    required this.amount,
    required this.transactionTime,
    required this.notes,
    required this.files,
    required this.isEditedLocally,
    required this.updatedAt,
    required this.syncedAt,
  });

  TransactionModel copyWith({
    String? id,
    String? remoteId,
    String? transactionType,
    Category? category,
    double? amount,
    DateTime? transactionTime,
    String? notes,
    List<Uint8List>? files,
    bool? isEditedLocally,
    DateTime? updatedAt,
    DateTime? syncedAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      transactionType: transactionType ?? this.transactionType,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      transactionTime: transactionTime ?? this.transactionTime,
      notes: notes ?? this.notes,
      files: files ?? this.files,
      isEditedLocally: isEditedLocally ?? this.isEditedLocally,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }
}

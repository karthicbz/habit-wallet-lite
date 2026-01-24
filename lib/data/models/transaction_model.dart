import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
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
  final String? id;
  final String? remoteId;

  final Transaction? transactionType;
  final Category? category;
  final double? amount;
  final DateTime? transactionDate;

  final String? notes;
  final List<PlatformFile>? files;

  final bool? isEditedLocally;
  final DateTime? updatedAt;
  final DateTime? syncedAt;

  TransactionModel({
    this.id,
    this.remoteId,
    this.transactionType,
    this.category,
    this.amount,
    this.transactionDate,
    this.notes,
    this.files,
    this.isEditedLocally,
    this.updatedAt,
    this.syncedAt,
  });

  TransactionModel copyWith({
    String? id,
    String? remoteId,
    Transaction? transactionType,
    Category? category,
    double? amount,
    DateTime? transactionDate,
    String? notes,
    List<PlatformFile>? files,
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
      transactionDate: transactionDate ?? this.transactionDate,
      notes: notes ?? this.notes,
      files: files ?? this.files,
      isEditedLocally: isEditedLocally ?? this.isEditedLocally,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }
}

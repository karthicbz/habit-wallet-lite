import 'package:hive_ce_flutter/adapters.dart';

class SyncModel extends HiveObject{
  final DateTime lastSynced;
  final bool isSyncing;

  SyncModel({
    required this.lastSynced,
    required this.isSyncing,
  });

  SyncModel copyWith({
    DateTime? lastSynced,
    bool? isSyncing,
  }) {
    return SyncModel(
      lastSynced: lastSynced ?? this.lastSynced,
      isSyncing: isSyncing ?? this.isSyncing,
    );
  }
}
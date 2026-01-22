import 'package:habit_wallet_lite/hive/hive_adapters.dart';
import 'package:hive_ce_flutter/adapters.dart';

enum Language { english, tamil }

class SettingsModel extends HiveObject {
  final bool darkMode;
  final Language language;
  final bool remainder;

  SettingsModel copyWith({
    bool? darkMode,
    Language? language,
    bool? remainder,
  }) {
    return SettingsModel(
      darkMode: darkMode ?? this.darkMode,
      language: language ?? this.language,
      remainder: remainder ?? this.remainder,
    );
  }

  SettingsModel({
    required this.darkMode,
    required this.language,
    required this.remainder,
  });
}

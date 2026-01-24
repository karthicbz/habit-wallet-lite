import 'package:hive_ce_flutter/adapters.dart';

enum Language { english, tamil }

class SettingsModel extends HiveObject {
  final bool darkMode;
  final Language language;
  final bool remainder;
  final bool autoLogin;

  SettingsModel({
    required this.darkMode,
    required this.language,
    required this.remainder,
    required this.autoLogin,
  });

  SettingsModel copyWith({
    bool? darkMode,
    Language? language,
    bool? remainder,
    bool? autoLogin,
  }) {
    return SettingsModel(
      darkMode: darkMode ?? this.darkMode,
      language: language ?? this.language,
      remainder: remainder ?? this.remainder,
      autoLogin: autoLogin ?? this.autoLogin,
    );
  }
}

enum Language{
  english, tamil;
}

class SettingsModel {
  final bool darkMode;
  final Language language;
  final bool remainder;

  const SettingsModel({
    required this.darkMode,
    required this.language,
    required this.remainder,
  });

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
}
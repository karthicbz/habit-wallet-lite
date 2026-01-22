import 'package:habit_wallet_lite/data/models/settings_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  SettingsModel build(){
    return SettingsModel(darkMode: false, language: Language.english, remainder: false);
  }

  void updateDarkMode(){
    state = state.copyWith(darkMode: !state.darkMode);
  }

  void updateRemainder(){
    state = state.copyWith(remainder: !state.remainder);
  }
}
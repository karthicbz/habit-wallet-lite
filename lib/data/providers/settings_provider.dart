import 'package:habit_wallet_lite/data/models/settings_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../constants/hive_boxes.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  late Box<SettingsModel> _settings;

  @override
  SettingsModel build() {
    _settings = Hive.box(settingsBox);
    if (_settings.isEmpty) {
      return SettingsModel(
        darkMode: false,
        language: Language.english,
        remainder: false,
        autoLogin: false,
      );
    } else {
      return _settings.values.first;
    }
  }

  void updateDarkMode() async{
    state = state.copyWith(darkMode: !state.darkMode);
    await updateHiveBox();
  }

  void updateRemainder() async{
    state = state.copyWith(remainder: !state.remainder);
    await updateHiveBox();
  }

  void updateAutoLogin() async{
    state = state.copyWith(autoLogin: !state.autoLogin);
    await updateHiveBox();
  }

  Future<void> updateHiveBox() async{
    await _settings.clear();
    await _settings.add(
      SettingsModel(
        darkMode: state.darkMode,
        language: Language.english,
        remainder: state.remainder,
        autoLogin: state.autoLogin,
      ),
    );
  }
}

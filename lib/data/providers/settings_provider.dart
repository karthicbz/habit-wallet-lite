import 'package:habit_wallet_lite/data/models/settings_model.dart';
import 'package:habit_wallet_lite/data/providers/notification_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../constants/hive_boxes.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  late Box<SettingsModel> _settings;
  late NotificationNotifier _notificationNotifier;

  @override
  SettingsModel build() {
    _settings = Hive.box(settingsBox);
    _notificationNotifier = ref.read(notificationProvider.notifier);

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

  void updateDarkMode() async {
    state = state.copyWith(darkMode: !state.darkMode);
    await updateHiveBox();
  }

  void updateRemainder() async {
    _notificationNotifier.showNotificationPermission();
    if (!state.remainder) {
      await _notificationNotifier.scheduleNotification(
        title: "Daily Expense Remainder.",
        body: "You haven’t added any expenses today.",
        hour: 20,
        minute: 00,
      );
    }else{
      await _notificationNotifier.cancelAllNotifications();
    }
    state = state.copyWith(remainder: !state.remainder);
    await updateHiveBox();
  }

  void updateAutoLogin() async {
    state = state.copyWith(autoLogin: !state.autoLogin);
    await updateHiveBox();
  }

  bool isAutoLoginEnabled() {
    return state.autoLogin;
  }

  Future<void> updateHiveBox() async {
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

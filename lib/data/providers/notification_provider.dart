import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'notification_provider.g.dart';

@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void build() {}

  void showNotificationPermission() async {
    if (await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.areNotificationsEnabled() ==
        false) {
      _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }
  }

  void initializeNotification() async {
    const initAndroidSettings = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );

    const initSettings = InitializationSettings(android: initAndroidSettings);

    await _flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "daily_channel_id",
        "Daily Notification",
        priority: Priority.high,
        importance: Importance.max,
        playSound: true,
      ),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }
}

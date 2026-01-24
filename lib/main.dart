import 'package:flutter/material.dart';
import 'package:habit_wallet_lite/data/constants/hive_boxes.dart';
import 'package:habit_wallet_lite/data/models/settings_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/data/providers/notification_provider.dart';
import 'package:habit_wallet_lite/data/providers/settings_provider.dart';
import 'package:habit_wallet_lite/hive/hive_registrar.g.dart';
import 'package:habit_wallet_lite/views/pages/login_page.dart';
import 'package:habit_wallet_lite/views/pages/navigation_page.dart';
import 'package:habit_wallet_lite/views/pages/settings_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationNotifier().initializeNotification();
  //initializing hive
  await Hive.initFlutter();
  //registering hive adapters
  Hive.registerAdapters();
  //opening hive boxes
  await Hive.openBox<SettingsModel>(settingsBox);
  await Hive.openBox<TransactionModel>(transactionBox);
  await Hive.openBox<bool>(transactionStatusBox);

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsModel settings = ref.watch(settingsProvider);
    SettingsNotifier settingsNotifier = ref.read(settingsProvider.notifier);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.greenAccent,
          brightness: (settings.darkMode) ? Brightness.dark : Brightness.light,
        ),
      ),
      home: (settingsNotifier.isAutoLoginEnabled())
          ? NavigationPage()
          : LoginPage(),
    );
  }
}

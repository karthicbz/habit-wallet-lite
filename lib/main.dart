import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habit_wallet_lite/data/constants/app_constants.dart';
import 'package:habit_wallet_lite/data/constants/hive_boxes.dart';
import 'package:habit_wallet_lite/data/models/app_locale_model.dart';
import 'package:habit_wallet_lite/data/models/settings_model.dart';
import 'package:habit_wallet_lite/data/models/sync_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_category_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/data/providers/locale_provider.dart';
import 'package:habit_wallet_lite/data/providers/notification_provider.dart';
import 'package:habit_wallet_lite/data/providers/settings_provider.dart';
import 'package:habit_wallet_lite/hive/hive_registrar.g.dart';
import 'package:habit_wallet_lite/l10n/app_localizations.dart';
import 'package:habit_wallet_lite/views/pages/login_page.dart';
import 'package:habit_wallet_lite/views/pages/navigation_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await NotificationNotifier().initializeNotification();
  //initializing hive
  await Hive.initFlutter();
  //registering hive adapters
  Hive.registerAdapters();
  //opening hive boxes
  await Hive.openBox<SettingsModel>(settingsBox);
  await Hive.openBox<TransactionModel>(transactionBox);
  await Hive.openBox<bool>(transactionStatusBox);
  await Hive.openBox<TransactionCategoryModel>(transactionCategoryBox);
  await Hive.openBox<SyncModel>(syncBox);
  await Hive.openBox<AppLocaleModel>(localeBox);

  //checking for auto login
  Box<SettingsModel> settings = Hive.box<SettingsModel>(settingsBox);
  Widget initialHome = LoginPage();
  if (settings.isNotEmpty) {
    if (settings.values.first.autoLogin) {
      initialHome = NavigationPage();
    }
  }

  runApp(ProviderScope(child: MyApp(initialHome: initialHome)));
}

class MyApp extends ConsumerWidget {
  final Widget initialHome;
  const MyApp({super.key, required this.initialHome});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsModel settings = ref.watch(settingsProvider);
    // SettingsNotifier settingsNotifier = ref.read(settingsProvider.notifier);

    // AppLocaleModel appLocaleModel = ref.watch();
    AppLocaleModel appLocaleModel = ref.watch(localeProvider);
    return MaterialApp(
      locale: Locale(appLocaleModel.appLocale.name),
      supportedLocales: [Locale(AppLocale.en.name), Locale(AppLocale.ta.name)],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent,
          brightness: (settings.darkMode) ? Brightness.dark : Brightness.light,
        ),
      ),
      home: initialHome,
    );
  }
}

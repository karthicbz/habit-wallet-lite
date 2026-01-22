import 'package:flutter/material.dart';
import 'package:habit_wallet_lite/data/constants/hive_boxes.dart';
import 'package:habit_wallet_lite/hive/hive_registrar.g.dart';
import 'package:habit_wallet_lite/views/pages/login_page.dart';
import 'package:habit_wallet_lite/views/pages/settings_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //initializing hive
  await Hive.initFlutter();
  //registering hive adapters
  Hive.registerAdapters();
  //opening hive boxes
  await Hive.openBox(settingsBox);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.greenAccent),
      ),
      home:  LoginPage(),
    );
  }
}
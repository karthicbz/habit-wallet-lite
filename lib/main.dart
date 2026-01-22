import 'package:flutter/material.dart';
import 'package:habit_wallet_lite/views/pages/login_page.dart';
import 'package:habit_wallet_lite/views/pages/settings_page.dart';

void main() {
  runApp(const MyApp());
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
      home:  SettingsPage(),
    );
  }
}
import 'package:habit_wallet_lite/data/constants/app_constants.dart';
import 'package:hive_ce_flutter/adapters.dart';

class AppLocaleModel extends HiveObject{
  final AppLocale appLocale;

  AppLocaleModel({
    required this.appLocale,
  });

  AppLocaleModel copyWith({
    AppLocale? appLocale,
  }) {
    return AppLocaleModel(
      appLocale: appLocale ?? this.appLocale,
    );
  }
}
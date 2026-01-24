import 'dart:typed_data';

import 'package:habit_wallet_lite/data/constants/app_constants.dart';
import 'package:habit_wallet_lite/data/models/settings_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:hive_ce/hive.dart';

import '../data/models/app_locale_model.dart';
import '../data/models/sync_model.dart';
import '../data/models/transaction_category_model.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<SettingsModel>(),
  AdapterSpec<Language>(),
  AdapterSpec<Transaction>(),
  AdapterSpec<Category>(),
  AdapterSpec<TransactionModel>(),
  AdapterSpec<TransactionCategoryModel>(),
  AdapterSpec<SyncModel>(),
  AdapterSpec<AppLocale>(),
  AdapterSpec<AppLocaleModel>()
])

class HiveAdapters {}
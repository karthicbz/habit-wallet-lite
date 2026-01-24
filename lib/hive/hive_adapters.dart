import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:habit_wallet_lite/data/constants/app_constants.dart';
import 'package:habit_wallet_lite/data/models/settings_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

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
  AdapterSpec<AppLocaleModel>(),
  AdapterSpec<PlatformFile>()
])

class HiveAdapters {}
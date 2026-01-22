import 'package:habit_wallet_lite/data/models/settings_model.dart';
import 'package:hive_ce/hive.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<SettingsModel>(),
])

class HiveAdapters {}
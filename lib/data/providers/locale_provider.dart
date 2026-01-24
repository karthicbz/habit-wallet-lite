import 'package:habit_wallet_lite/data/constants/app_constants.dart';
import 'package:habit_wallet_lite/data/constants/hive_boxes.dart';
import 'package:habit_wallet_lite/data/models/app_locale_model.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'locale_provider.g.dart';
@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  late Box<AppLocaleModel> _appLocaleModel;
  @override
  AppLocaleModel build(){
    _appLocaleModel = Hive.box(localeBox);
    // print("AppLocaleBox: ${_appLocaleModel.values.first}");
    if(_appLocaleModel.isEmpty){
      return AppLocaleModel(appLocale: AppLocale.en);
    }else{
      return _appLocaleModel.values.first;
    }
  }

  void changeLocale(AppLocale locale){
    state = state.copyWith(appLocale: locale);
    _appLocaleModel.clear();
    _appLocaleModel.add(state);
  }
}


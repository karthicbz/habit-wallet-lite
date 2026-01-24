import 'package:flutter/cupertino.dart';

import '../../l10n/app_localizations.dart';
import '../models/transaction_model.dart';

class AppHelper {
  String convertEnumToString(Category category, BuildContext context) {
    switch (category) {
      case Category.education:
        return AppLocalizations.of(context)!.educationText;
      case Category.foodAndGroceries:
        return AppLocalizations.of(context)!.foodAndBeverageText;
      case Category.transport:
        return AppLocalizations.of(context)!.transportText;
      case Category.shopping:
        return AppLocalizations.of(context)!.shoppingText;
      case Category.utilities:
        return AppLocalizations.of(context)!.utilitiesText;
      case Category.medicine:
        return AppLocalizations.of(context)!.medicineText;
      case Category.others:
        return AppLocalizations.of(context)!.othersText;
    }
  }
}
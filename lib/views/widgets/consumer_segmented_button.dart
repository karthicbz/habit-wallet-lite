import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/constants/app_constants.dart';
import '../../data/models/app_locale_model.dart';
import '../../data/providers/locale_provider.dart';

class ConsumerSegmentedButton extends StatelessWidget {
  const ConsumerSegmentedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        AppLocaleModel appLocaleModel = ref.watch(localeProvider);
        LocaleNotifier localeNotifier = ref.read(
          localeProvider.notifier,
        );
        return SegmentedButton(
          segments: <ButtonSegment<AppLocale>>[
            ButtonSegment(value: AppLocale.en, label: Text("EN")),
            ButtonSegment(value: AppLocale.ta, label: Text("அ")),
          ],
          selected: {appLocaleModel.appLocale},
          onSelectionChanged: (newSelection) {
            // print(newSelection);
            HapticFeedback.mediumImpact();
            // transactionNotifier.updateTransactionType(newSelection);
            localeNotifier.changeLocale(newSelection.first);
          },
        );
      },
    );
  }
}

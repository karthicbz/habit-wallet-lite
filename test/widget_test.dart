// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_wallet_lite/data/constants/app_constants.dart';
import 'package:habit_wallet_lite/data/models/app_locale_model.dart';
import 'package:habit_wallet_lite/data/models/settings_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_category_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/data/providers/locale_provider.dart';
import 'package:habit_wallet_lite/data/providers/settings_provider.dart';
import 'package:habit_wallet_lite/data/providers/transaction_category_provider.dart';
import 'package:habit_wallet_lite/data/providers/transaction_list_provider.dart';

import 'package:habit_wallet_lite/main.dart';
import 'package:habit_wallet_lite/views/pages/login_page.dart';

// Mock Notifiers
class MockSettingsNotifier extends SettingsNotifier {
  @override
  SettingsModel build() {
    return SettingsModel(
      darkMode: false,
      language: Language.english,
      remainder: false,
      autoLogin: false,
    );
  }
}

class MockLocaleNotifier extends LocaleNotifier {
  @override
  AppLocaleModel build() {
    return AppLocaleModel(appLocale: AppLocale.en);
  }
}

class MockTransactionListNotifier extends TransactionListNotifier {
  @override
  TransactionListHelper build() {
    return TransactionListHelper(
      transactionModel: [],
      isLoading: false,
      dummyTransactionModel: [],
    );
  }
}

class MockTransactionCategoryNotifier extends TransactionCategoryNotifier {
  @override
  List<TransactionCategoryModel> build() {
    // Return a basic list of categories with 0 spent/limit
    return Category.values
        .map(
          (c) => TransactionCategoryModel(category: c, limit: 0.0, spent: 0.0),
        )
        .toList();
  }
}

void main() {
  testWidgets('App launches without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsProvider.overrideWith(() => MockSettingsNotifier()),
          localeProvider.overrideWith(() => MockLocaleNotifier()),
          transactionListProvider.overrideWith(
            () => MockTransactionListNotifier(),
          ),
          transactionCategoryProvider.overrideWith(
            () => MockTransactionCategoryNotifier(),
          ),
        ],
        child: const MyApp(initialHome: LoginPage()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MyApp), findsOneWidget);
    expect(find.byType(LoginPage), findsOneWidget);
  });
}

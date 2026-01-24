// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_wallet_lite/data/providers/transaction_category_provider.dart';
import 'package:habit_wallet_lite/data/providers/transaction_list_provider.dart';

import 'package:habit_wallet_lite/main.dart';
import 'package:habit_wallet_lite/views/pages/login_page.dart';

void main() {
  testWidgets('App launches without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transactionListProvider.overrideWith(
                () => TransactionListNotifier(),
          ),
          transactionCategoryProvider.overrideWith(
                () => TransactionCategoryNotifier(),
          ),
        ],
        child: const MyApp(
          initialHome: LoginPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MyApp), findsOneWidget);
    expect(find.byType(LoginPage), findsOneWidget);
  });
}

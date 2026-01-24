import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/data/providers/navigation_index_provider.dart';
import 'package:habit_wallet_lite/views/pages/expenses_page.dart';
import 'package:habit_wallet_lite/views/pages/overview_page.dart';
import 'package:habit_wallet_lite/views/pages/settings_page.dart';
import 'package:habit_wallet_lite/views/pages/transaction_page.dart';

import '../../l10n/app_localizations.dart';

class NavigationPage extends ConsumerWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentPageIndex = ref.watch(navigationIndexProvider);
    NavigationIndexNotifier navigationIndexNotifier = ref.read(
      navigationIndexProvider.notifier,
    );

    List<Widget> destinations = [
      NavigationDestination(
        // selectedIcon: Icon(Icons.home),
        icon: Icon(Icons.dashboard),
        label: AppLocalizations.of(context)!.overviewText,
      ),
      NavigationDestination(
        icon: Icon(Icons.receipt_long),
        label: AppLocalizations.of(context)!.transactionText,
      ),
      NavigationDestination(
        icon: Icon(Icons.settings),
        label: AppLocalizations.of(context)!.settingsText,
      ),
    ];

    List<Widget> pages = [
      OverviewPage(),
      TransactionPage(),
      SettingsPage()
    ];

    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: destinations,
        onDestinationSelected: (index) =>
            navigationIndexNotifier.updateIndex(index),
        selectedIndex: currentPageIndex,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';
import 'package:habit_wallet_lite/data/models/chart_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_category_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/data/providers/chart_provider.dart';
import 'package:habit_wallet_lite/data/providers/transaction_category_provider.dart';
import 'package:habit_wallet_lite/data/providers/transaction_list_provider.dart';
import 'package:habit_wallet_lite/l10n/app_localizations.dart';
import 'package:habit_wallet_lite/views/pages/new_transaction_page.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class OverviewPage extends ConsumerStatefulWidget {
  const OverviewPage({super.key});

  @override
  ConsumerState<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends ConsumerState<OverviewPage> {
  @override
  void initState() {
    super.initState();
    final chartNotifier = ref.read(chartProvider.notifier);
    final transactionListNotifier = ref.read(transactionListProvider.notifier);
    Future.delayed(Duration.zero, () async {
      await transactionListNotifier.loadJsonFromFile();
      chartNotifier.getChartData();
    });
  }

  String convertEnumToString(Category category) {
    switch (category) {
      case Category.education:
        return educationText;
      case Category.foodAndGroceries:
        return foodAndBeverageText;
      case Category.transport:
        return transportText;
      case Category.shopping:
        return shoppingText;
      case Category.utilities:
        return utilitiesText;
      case Category.medicine:
        return medicineText;
      case Category.others:
        return othersText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                dashboardText,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  // ChartNotifier chartNotifier = ref.read(chartProvider.notifier);
                  List<ChartModel> chartModel = ref.watch(chartProvider);

                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <CartesianSeries>[
                        ColumnSeries<ChartModel, String>(
                          dataSource: chartModel,
                          xValueMapper: (m, _) =>
                              DateFormat('MMM yyyy').format(m.month!),
                          yValueMapper: (m, _) => m.debit,
                          name: 'Debit',
                          color: Theme.of(context).colorScheme.error,
                        ),
                        ColumnSeries<ChartModel, String>(
                          dataSource: chartModel,
                          xValueMapper: (m, _) =>
                              DateFormat('MMM yyyy').format(m.month!),
                          yValueMapper: (m, _) => m.credit,
                          name: 'Credit',
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  );
                },
              ),

              Text(
                AppLocalizations.of(context)!.categoryBreakDownText,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Consumer(
                builder: (context, ref, child) {
                  List<TransactionCategoryModel> transactionCategory = ref
                      .watch(transactionCategoryProvider);
                  return Expanded(
                    child: ListView.builder(
                      itemCount: transactionCategory.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          child:
                              (transactionCategory[index].category ==
                                  Category.education)
                              ? Icon(Icons.book)
                              : (transactionCategory[index].category ==
                                    Category.foodAndGroceries)
                              ? Icon(Icons.fastfood)
                              : (transactionCategory[index].category ==
                                    Category.medicine)
                              ? Icon(Icons.local_hospital)
                              : (transactionCategory[index].category ==
                                    Category.shopping)
                              ? Icon(Icons.shopping_bag)
                              : (transactionCategory[index].category ==
                                    Category.transport)
                              ? Icon(Icons.emoji_transportation)
                              : (transactionCategory[index].category ==
                                    Category.utilities)
                              ? Icon(Icons.home)
                              : Icon(Icons.star),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Text(transactionCategory[index].category.name),
                            Text(
                              convertEnumToString(
                                transactionCategory[index].category,
                              ),
                            ),
                            Text(transactionCategory[index].spent.toString()),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            LinearProgressIndicator(
                              value: 0.4,
                              minHeight: 10,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            Text("40% of ${transactionCategory[index].limit}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Expanded(child: Lis)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewTransactionPage()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

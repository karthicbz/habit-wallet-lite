import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';
import 'package:habit_wallet_lite/data/models/transaction_category_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/data/providers/transaction_category_provider.dart';
import 'package:habit_wallet_lite/views/pages/new_transaction_page.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

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
              SizedBox(height: MediaQuery.of(context).size.height / 2.5),
              Text(
                categoryBreakDownText,
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
                            Text(transactionCategory[index].category.name),
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

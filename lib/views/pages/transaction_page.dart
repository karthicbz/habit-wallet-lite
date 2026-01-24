import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';
import 'package:habit_wallet_lite/data/providers/transaction_list_provider.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../../data/constants/hive_boxes.dart';
import '../../data/models/transaction_model.dart';

class TransactionPage extends ConsumerStatefulWidget {
  const TransactionPage({super.key});

  @override
  ConsumerState<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends ConsumerState<TransactionPage> {
  @override
  void initState() {
    super.initState();
    final transactionListNotifier = ref.read(transactionListProvider.notifier);
    Future.delayed(
      Duration.zero,
      () async => await transactionListNotifier.loadJsonFromFile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    TransactionListHelper transactionListHelper = ref.watch(
      transactionListProvider,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transactionTitle,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              (transactionListHelper.isLoading)
                  ? LinearProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        addAutomaticKeepAlives: true,
                        itemCount:
                            transactionListHelper.transactionModel.length,
                        itemBuilder: (context, index) => ListTile(
                          isThreeLine: true,

                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                child:
                                    (transactionListHelper
                                            .transactionModel[index]
                                            .transactionType ==
                                        Transaction.income)
                                    ? Icon(Icons.arrow_forward_outlined)
                                    : Icon(Icons.arrow_back),
                              ),
                            ],
                          ),
                          title: Row(
                            spacing: 4,
                            children: [
                              Text(
                                transactionListHelper
                                        .transactionModel[index]
                                        .category
                                        ?.name ??
                                    "Other",
                              ),
                              (transactionListHelper
                                          .transactionModel[index]
                                          .isEditedLocally ??
                                      false)
                                  ? Badge(
                                      label: Text("Edited Locally"),
                                      backgroundColor: Colors.yellow[200],
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (transactionListHelper
                                                .transactionModel[index]
                                                .notes !=
                                            null &&
                                        transactionListHelper
                                            .transactionModel[index]
                                            .notes!
                                            .isEmpty)
                                    ? "No note found"
                                    : transactionListHelper
                                              .transactionModel[index]
                                              .notes ??
                                          "No notes found.",
                              ),
                              Text(
                                DateFormat('MMM dd, yyyy').format(
                                  transactionListHelper
                                      .transactionModel[index]
                                      .transactionDate!,
                                ),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${(transactionListHelper.transactionModel[index].transactionType == Transaction.income) ? "+" : "-"}${transactionListHelper.transactionModel[index].amount}",
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

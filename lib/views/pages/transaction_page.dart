import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/data/constants/app_helper.dart';
import 'package:habit_wallet_lite/data/providers/transaction_list_provider.dart';
import 'package:habit_wallet_lite/views/pages/new_transaction_page.dart';
import 'package:intl/intl.dart';
import '../../data/models/transaction_model.dart';
import '../../l10n/app_localizations.dart';

class TransactionPage extends ConsumerStatefulWidget {
  const TransactionPage({super.key});

  @override
  ConsumerState<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends ConsumerState<TransactionPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // final transactionListNotifier = ref.read(transactionListProvider.notifier);
    // Future.delayed(
    //   Duration.zero,
    //   () async => await transactionListNotifier.loadJsonFromFile(),
    // );
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.transactionText,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SearchBar(
                leading: Icon(Icons.search),
                hintText: "Search Transaction",
                elevation: WidgetStatePropertyAll(1),
                controller: searchController,
                onChanged: (value) => ref
                    .read(transactionListProvider.notifier)
                    .searchTransaction(value.toLowerCase()),
              ),
              SizedBox(height: 8),
              (transactionListHelper.isLoading)
                  ? LinearProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        addAutomaticKeepAlives: true,
                        itemCount:
                            transactionListHelper.transactionModel.length,
                        itemBuilder: (context, index) => ListTile(
                          dense: true,
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewTransactionPage(
                                  id: transactionListHelper
                                      .transactionModel[index]
                                      .id,
                                ),
                              ),
                            );
                            //refresh the transaction list on return
                            ref.invalidate(transactionListProvider);
                          },
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
                                    ? Icon(
                                        Icons.arrow_forward_outlined,
                                        size: 20,
                                      )
                                    : Icon(Icons.arrow_back),
                              ),
                            ],
                          ),
                          title: Row(
                            spacing: 4,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  AppHelper().convertEnumToString(
                                    transactionListHelper
                                            .transactionModel[index]
                                            .category ??
                                        Category.others,
                                    context,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // (transactionListHelper
                              //             .transactionModel[index]
                              //             .isEditedLocally ??
                              //         false)
                              //     ? Badge(
                              //         label: Text("Edited Locally"),
                              //         backgroundColor: Colors.orange[300],
                              //       )
                              //     : SizedBox.shrink(),
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
                                    ? AppLocalizations.of(
                                        context,
                                      )!.noNotesFoundText
                                    : transactionListHelper
                                              .transactionModel[index]
                                              .notes ??
                                          AppLocalizations.of(
                                            context,
                                          )!.noNotesFoundText,
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
                                "${(transactionListHelper.transactionModel[index].transactionType == Transaction.income) ? "+₹" : "-₹"}${transactionListHelper.transactionModel[index].amount}",
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

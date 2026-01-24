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
    final _transactionListNotifier = ref.read(transactionListProvider.notifier);
    Future.delayed(
      Duration.zero,
      () => _transactionListNotifier.loadJsonFromFile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Box<TransactionModel> _transactions = Hive.box(transactionBox);
    List<TransactionModel> _transactionList = _transactions.values.toList();

    // List<TransactionModel> _transactionList = ref.watch(transactionListProvider);
    print(_transactionList.first.amount);

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
              (_transactionList.isEmpty)
                  ? LinearProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        addAutomaticKeepAlives: true,
                        itemCount: _transactionList.length,
                        itemBuilder: (context, index) => ListTile(
                          isThreeLine: true,

                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                child:
                                    (_transactionList[index].transactionType ==
                                        Transaction.income)
                                    ? Icon(Icons.arrow_forward_outlined)
                                    : Icon(Icons.arrow_back),
                              ),
                            ],
                          ),
                          title: Text(
                            _transactionList[index].category?.name ?? "Other",
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (_transactionList[index].notes != null &&
                                        _transactionList[index].notes!.isEmpty)
                                    ? "No note found"
                                    : _transactionList[index].notes ??
                                          "No notes found.",
                              ),
                              Text(
                                DateFormat('MMM dd, yyyy').format(
                                  _transactionList[index].transactionDate!,
                                ),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${(_transactionList[index].transactionType == Transaction.income) ? "+" : "-"}${_transactionList[index].amount}",
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

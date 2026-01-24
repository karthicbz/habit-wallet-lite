import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/data/providers/transaction_provider.dart';
import 'package:habit_wallet_lite/views/widgets/custom_page_route.dart';
import 'package:habit_wallet_lite/views/widgets/custom_textfield.dart';
import 'package:habit_wallet_lite/views/widgets/show_scaffold_message.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';

class NewTransactionPage extends ConsumerStatefulWidget {
  final String? id;

  const NewTransactionPage({super.key, this.id});

  @override
  ConsumerState<NewTransactionPage> createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends ConsumerState<NewTransactionPage> {
  TextEditingController amountEditingController = TextEditingController(
    text: "0.0",
  );
  TextEditingController transactionDateController = TextEditingController(
    text: DateFormat('MMM dd, yyyy').format(DateTime.now()),
  );
  TextEditingController categoryController = TextEditingController(
    text: Category.others.name,
  );
  TextEditingController notesController = TextEditingController();
  late CustomPageRoute customPageRoute;

  @override
  void initState() {
    super.initState();
    customPageRoute = CustomPageRoute(context: context);
    if (widget.id != null) {
      final transactionNotifier = ref.read(transactionProvider.notifier);
      Future.delayed(Duration.zero, () {
        transactionNotifier.loadTransactionForEdit(
          widget.id!,
          amountEditingController,
          notesController,
          transactionDateController,
          categoryController,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TransactionModel transactionModel = ref.watch(transactionProvider);
    TransactionNotifier transactionNotifier = ref.read(
      transactionProvider.notifier,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => customPageRoute.pop(),
          icon: Icon(Icons.close),
        ),
        title: Text(
          (widget.id == null)
              ? AppLocalizations.of(context)!.addTransactionText
              : AppLocalizations.of(context)!.editTransactionText,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          TextButton(
            onPressed: () {
              transactionNotifier.saveTransaction(
                amountEditingController.text,
                notesController.text,
                widget.id,
              );
              showScaffoldMessage("Transaction updated", context);
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context)!.saveText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 24,
              children: [
                Divider(color: Theme.of(context).dividerColor),
                SegmentedButton(
                  segments: <ButtonSegment<Transaction>>[
                    ButtonSegment(
                      value: Transaction.expense,
                      label: Text(AppLocalizations.of(context)!.expenseText),
                    ),
                    ButtonSegment(
                      value: Transaction.income,
                      label: Text(AppLocalizations.of(context)!.incomeText),
                    ),
                  ],
                  selected: {transactionModel.transactionType},
                  onSelectionChanged: (newSelection) {
                    // print(newSelection);
                    HapticFeedback.mediumImpact();
                    transactionNotifier.updateTransactionType(newSelection);
                  },
                ),
                CustomTextField(
                  textEditingController: amountEditingController,
                  label: AppLocalizations.of(context)!.amountText,
                  isPassword: false,
                  textInputType: TextInputType.number,
                ),
                TextField(
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.categoryText,
                    border: OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                      child: Icon(Icons.arrow_drop_down_outlined),
                      onTap: () {
                        transactionNotifier.updateCategory(
                          context,
                          categoryController,
                        );
                      },
                    ),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  controller: transactionDateController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.dateText,
                    border: OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                      child: Icon(Icons.calendar_month),
                      onTap: () async {
                        //passing texteditingcontroller reference
                        await transactionNotifier.updateTransactionDate(
                          context,
                          transactionDateController,
                        );
                      },
                    ),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  controller: notesController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.notesText,
                    border: OutlineInputBorder(),
                  ),
                ),
                ListTile(
                  title: Text(addAttachmentText),
                  subtitle: Text(uploadReceiptText),
                  trailing: Icon(Icons.attach_file),
                  onTap: () async => await transactionNotifier.showFilePicker(),
                ),
                Column(
                  children: (transactionModel.files != null)
                      ? transactionModel.files!
                            .map(
                              (file) =>
                                  // Card(child: Text("${file.name}${file.extension}")),
                                  ListTile(
                                    title: Text(file.name),
                                    subtitle: Text(
                                      "${(file.size / 1000000).toStringAsFixed(2)}MB",
                                    ),
                                    trailing: IconButton(
                                      onPressed: () => transactionNotifier
                                          .removeFiles(file.name),
                                      icon: Icon(Icons.cancel),
                                    ),
                                  ),
                            )
                            .toList()
                      : [],
                ),
                Divider(color: Theme.of(context).dividerColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

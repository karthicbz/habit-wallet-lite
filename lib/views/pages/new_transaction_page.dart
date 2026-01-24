import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:habit_wallet_lite/data/providers/transaction_provider.dart';
import 'package:habit_wallet_lite/views/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class NewTransactionPage extends ConsumerStatefulWidget {
  const NewTransactionPage({super.key});

  @override
  ConsumerState<NewTransactionPage> createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends ConsumerState<NewTransactionPage> {
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController transactionDateController = TextEditingController(
    text: DateFormat('MMM dd, yyyy').format(DateTime.now()),
  );
  TextEditingController categoryController = TextEditingController(
    text: Category.others.name,
  );

  @override
  Widget build(BuildContext context) {
    TransactionModel transactionModel = ref.watch(transactionProvider);
    TransactionNotifier transactionNotifier = ref.read(
      transactionProvider.notifier,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
        title: Text(
          addTransactionText,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Save", style: Theme.of(context).textTheme.bodyLarge),
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
                      label: Text("Expense"),
                    ),
                    ButtonSegment(
                      value: Transaction.income,
                      label: Text("Income"),
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
                  label: amountText,
                  isPassword: false,
                  textInputType: TextInputType.number,
                ),
                TextField(
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: categoryText,
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
                    labelText: dateText,
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
                  decoration: InputDecoration(
                    labelText: notesText,
                    border: OutlineInputBorder(),
                  ),
                ),
                ListTile(
                  title: Text(addAttachmentText),
                  subtitle: Text(uploadReceiptText),
                  trailing: Icon(Icons.attach_file),
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

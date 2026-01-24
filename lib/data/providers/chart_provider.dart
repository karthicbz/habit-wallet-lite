import 'package:habit_wallet_lite/data/constants/hive_boxes.dart';
import 'package:habit_wallet_lite/data/models/chart_model.dart';
import 'package:habit_wallet_lite/data/models/transaction_model.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chart_provider.g.dart';

@riverpod
class ChartNotifier extends _$ChartNotifier {
  late Box<TransactionModel> _transactionModel;

  @override
  List<ChartModel> build() {
    _transactionModel = Hive.box(transactionBox);
    return [];
  }

  DateTime monthKey(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  Map<DateTime, ChartModel> monthlyDebitCredit() {
    final List<TransactionModel> txns = _transactionModel.values.toList();

    final Map<DateTime, ChartModel> result = {};

    for (final txn in txns) {
      final date = DateTime.parse(txn.transactionDate.toString()).toLocal();
      final key = monthKey(date);

      result.putIfAbsent(key, () => ChartModel(month: key));

      final amount = double.parse(txn.amount.toString());
      final type = (txn.transactionType == Transaction.income)
          ? "DEBIT"
          : "CREDIT"; // "DEBIT" or "CREDIT"

      if (type == "DEBIT") {
        result[key]!.debit += amount;
      } else if (type == "CREDIT") {
        result[key]!.credit += amount;
      }
    }

    return result;
  }

  List<ChartModel> toSortedList(
      Map<DateTime, ChartModel> map,
      ) {
    final list = map.values.toList();
    list.sort((a, b) => a.month!.compareTo(b.month!));
    return list;
  }

  void getChartData(){
    List<ChartModel> data = toSortedList(monthlyDebitCredit());
    print(data);
  }

}

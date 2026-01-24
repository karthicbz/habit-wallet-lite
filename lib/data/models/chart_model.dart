class ChartModel {
  final DateTime? month;
  double debit;
  double credit;

  ChartModel({this.month, this.debit = 0, this.credit = 0});

  ChartModel copyWith({DateTime? month, double? debit, double? credit}) {
    return ChartModel(
      month: month ?? this.month,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
    );
  }
}

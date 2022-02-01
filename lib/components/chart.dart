import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool someDay = recentTransaction[i].date.day == weekDay.day;
        bool someMonth = recentTransaction[i].date.month == weekDay.month;
        bool someYear = recentTransaction[i].date.year == weekDay.year;

        if (someDay && someMonth && someYear) {
          totalSum += recentTransaction[i].value;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(
        0.0, (sum, tr) => sum + (tr['value'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactions.map((tr) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: tr['day'].toString(),
                  percentage: _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue,
                  value: (tr['value'] as double),
                ),
              );
            }).toList(),
            ),
      ),
    );
  }
}

import 'package:PersonalExpense/models/transaction.dart';
import 'package:PersonalExpense/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double sum = 0.0;

      for (int i = 0; i < recentTransaction.length; i++) {
        if (weekday.day == recentTransaction[i].date.day &&
            weekday.month == recentTransaction[i].date.month &&
            weekday.year == recentTransaction[i].date.year) {
          sum += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 2),
        'amount': sum,
      };
    }).reversed.toList();
  }

  double get totalWeekSpending {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum += element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((element) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: element['day'],
                totalSpending: element['amount'],
                spendingPctOfTotal: totalWeekSpending == 0.0
                    ? 0.0
                    : (element['amount'] as double) / totalWeekSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

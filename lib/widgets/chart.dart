import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({Key key, this.recentTransactions}) : super(key: key);

  List<Map<String, dynamic>> get groubedRecentTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay)[0]);
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    });
  }

  double get maxSpending {
    return groubedRecentTransactions.fold(0.0, (sum, item) {
      return (sum + item['amount']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groubedRecentTransactions.map((data) {
            return ChartBar(
                day: data['day'], amount: data['amount'], spendPercOfTrans: .5);
          }).toList(),
        ));
  }
}

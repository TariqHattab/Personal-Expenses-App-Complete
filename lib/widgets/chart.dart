import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({Key key, this.recentTransactions}) : super(key: key);

  List<Map<String, dynamic>> get groubedRecentTransactions {
    // the chart will display the percentage only for the last seven days
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      // calculate all transactions in a weekDay
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList(); //called reversed to reverse the list so it
    //                      goes from left to right instead from right to left
  }

  double get maxSpending {
    return groubedRecentTransactions.fold(0.0, (sum, item) {
      return (sum + item['amount']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: groubedRecentTransactions.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    day: data['day'],
                    amount: data['amount'],
                    spendPercOfTrans: recentTransactions.isEmpty
                        ? 0
                        : (data['amount'] / maxSpending)),
              );
            }).toList(),
          ),
        ));
  }
}

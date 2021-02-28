import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionsList({Key key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text('no taransactions added yet'),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 250,
                    child: Image.asset('assets/images/waiting.png'))
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 3)),
                          child: Text(
                            '\$${transactions[index].amount.toString()}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(transactions[index].title,
                                  style: Theme.of(context).textTheme.headline6),
                              Container(
                                  width: 210,
                                  child: Text(
                                    DateFormat('yyyy-MM-dd')
                                        .format(transactions[index].date),
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(color: Colors.grey),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}

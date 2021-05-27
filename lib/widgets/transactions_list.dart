import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/transaction_widget.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionsList({Key key, this.transactions, this.deleteTx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return transactions.isEmpty
            ? Column(
                children: [
                  Text('no taransactions added yet'),
                  SizedBox(
                    height: constraints.maxHeight * .1,
                  ),
                  Container(
                      height: constraints.maxHeight * .7,
                      child: Image.asset('assets/images/waiting.png'))
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return TransactionWidget(
                    tx: transactions[index],
                    deleteTx: deleteTx,
                  );
                },
                itemCount: transactions.length,
              );
      },
    );
  }
}

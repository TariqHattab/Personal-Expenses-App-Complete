import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction tx;
  final Function deleteTx;
  const TransactionWidget({Key key, this.tx, this.deleteTx}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: FittedBox(child: Text('\$${tx.amount.toStringAsFixed(0)}')),
          ),
        ),
        title: Text(tx.title),
        subtitle: Text(DateFormat('yyyy-MM-dd').format(tx.date)),
        trailing: MediaQuery.of(context).size.width > 460
            // ignore: deprecated_member_use
            ? FlatButton.icon(
                label: Text('Delete'),
                textColor: Theme.of(context).errorColor,
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteTx(tx);
                },
              )
            : IconButton(
                color: Theme.of(context).errorColor,
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteTx(tx);
                },
              ),
      ),
    );
  }
}

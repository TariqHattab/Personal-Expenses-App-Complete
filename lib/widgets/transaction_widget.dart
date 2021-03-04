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
        title: Text(tx.title),
        subtitle: Text(DateFormat('yyyy-MM-dd').format(tx.date)),
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: FittedBox(child: Text(tx.amount.toStringAsFixed(0))),
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 460
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
    )

        //  Card(
        //   elevation: 3,
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //     child: Row(
        //       children: [
        //         Container(
        //           padding: EdgeInsets.all(10),
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10),
        //               border: Border.all(
        //                   color: Theme.of(context).primaryColor, width: 3)),
        //           child: Text(
        //             '\$${tx.amount.toString()}',
        //             style: TextStyle(
        //                 fontSize: 16, color: Theme.of(context).primaryColor),
        //           ),
        //         ),
        //         Padding(
        //           padding: EdgeInsets.only(left: 10),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(tx.title, style: Theme.of(context).textTheme.headline6),
        //               Container(
        //                   child: Text(
        //                 DateFormat('yyyy-MM-dd').format(tx.date),
        //                 style: TextStyle(color: Colors.grey),
        //               ))
        //             ],
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // )
        ;
  }
}

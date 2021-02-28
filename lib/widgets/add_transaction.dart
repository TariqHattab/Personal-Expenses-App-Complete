import 'package:flutter/material.dart';

import '../models/transaction.dart';

class AddTransaction extends StatefulWidget {
  AddTransaction({
    Key key,
    this.addNewTx,
  }) : super(key: key);
  final Function addNewTx;

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'name'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: amountController,
              decoration: InputDecoration(labelText: 'amount'),
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              child: Text('Submit'),
              onPressed: () {
                final enteredTitle = titleController.text;
                final enteredAmount = double.parse(amountController.text);

                if (enteredTitle.isEmpty || enteredAmount <= 0) {
                  return;
                }

                widget.addNewTx(title: enteredTitle, amount: enteredAmount);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}

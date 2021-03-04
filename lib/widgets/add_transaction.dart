import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
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
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _datePicked;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _datePicked = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'name'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: InputDecoration(labelText: 'amount'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 70,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _datePicked == null
                        ? Text('No Date Choosen')
                        : Text(
                            'Picked Date:${DateFormat.yMd().format(_datePicked)}'),
                    FlatButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        _presentDatePicker();
                      },
                    )
                  ],
                ),
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              child: Text(
                'Add Transation',
              ),
              onPressed: () {
                if (_amountController.text == '') {
                  return;
                }

                final enteredTitle = _titleController.text;
                final enteredAmount = double.parse(_amountController.text);

                if (enteredTitle.isEmpty ||
                    enteredAmount <= 0 ||
                    _datePicked == null) {
                  return;
                }

                widget.addNewTx(
                    title: enteredTitle,
                    amount: enteredAmount,
                    date: _datePicked);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}

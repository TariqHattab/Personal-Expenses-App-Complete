import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double spendPercOfTrans;

  const ChartBar({Key key, this.day, this.amount, this.spendPercOfTrans})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$$amount'),
        Container(
          height: 50,
          width: 10,
          child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).primaryColor),
            ),
            heightFactor: spendPercOfTrans,
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[350], width: 1.0),
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10)),
        ),
        Text(day)
      ],
    )

        // Container(
        //   height: 30,
        //   width: 10,
        //   decoration: BoxDecoration(
        //       color: Colors.purple, borderRadius: BorderRadius.circular(10)),
        // ),
        ;
  }
}

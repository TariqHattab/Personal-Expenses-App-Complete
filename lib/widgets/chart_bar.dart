import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double spendPercOfTrans;

  const ChartBar({Key key, this.day, this.amount, this.spendPercOfTrans})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: constraints.maxHeight * .15,
                child:
                    FittedBox(child: Text('\$${amount.toStringAsFixed(0)}'))),
            SizedBox(
              height: constraints.maxHeight * .05,
            ),
            Container(
              height: constraints.maxHeight * .6,
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
            SizedBox(
              height: constraints.maxHeight * .05,
            ),
            Container(
                height: constraints.maxHeight * .15,
                child: FittedBox(child: Text(day[0])))
          ],
        );
      },
    );
  }
}

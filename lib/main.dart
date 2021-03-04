import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'widgets/chart.dart';
import './widgets/transactions_list.dart';
import './widgets/add_transaction.dart';
import 'models/transaction.dart';

void main() {
//To disable the landscape mode uncomment the following lines

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter spendings',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: MyHomePage(title: 'My spendings'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    // Transaction(
    //     id: '1',
    //     title: 'shoes',
    //     amount: 2,
    //     date: DateTime.now().subtract(Duration(hours: 1))),
    // Transaction(id: '2', title: 'office', amount: 12, date: DateTime.now()),
  ];

  get _recentTaransactions {
    //used the where function in the list class to excute a condition
    //on each element in a list and include it only if its true
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void deleteTransaction(Transaction tx) {
    setState(() {
      transactions.remove(tx);
    });
  }

  _createNewTaransaction({String title, double amount, DateTime date}) {
    var newTx = Transaction(
        id: DateTime.now().toString(),
        amount: amount,
        title: title,
        date: date);

    setState(() {
      transactions.add(newTx);
    });
  }

  void _showAddNewTransaction(BuildContext cxt) {
    showModalBottomSheet(
        context: cxt,
        builder: (_) {
          return AddTransaction(
            addNewTx: _createNewTaransaction,
          );
        });
  }

  var _showChart = false;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var isLandscape = mediaQuery.orientation == Orientation.landscape;

    var appbar = AppBar(
      centerTitle: false,
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showAddNewTransaction(context),
        )
      ],
    );
    var txListWidget = Container(
      height: (mediaQuery.size.height -
              appbar.preferredSize.height -
              mediaQuery.padding.top) *
          .7,
      child: TransactionsList(
        transactions: transactions,
        deleteTx: deleteTransaction,
      ),
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appbar.preferredSize.height -
                              mediaQuery.padding.top) *
                          .7,
                      child: Chart(
                        recentTransactions: _recentTaransactions,
                      ),
                    )
                  : txListWidget,
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appbar.preferredSize.height -
                        mediaQuery.padding.top) *
                    .3,
                child: Chart(
                  recentTransactions: _recentTaransactions,
                ),
              ),
            if (!isLandscape) txListWidget,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

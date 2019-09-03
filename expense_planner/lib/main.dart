import 'package:expense_planner/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/new_transactions.dart';
import './models/transaction.dart';
import 'widgets/transactions_list.dart';
import 'package:uuid/uuid.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   amount: 100.99,
    //   title: 'Shoes',
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   amount: 200.99,
    //   title: 'Grocery',
    //   date: DateTime.now(),
    // ),
  ];
  void _addNewTransaction(
      String txtitle, double txamount, DateTime transcationDate) {
    var uuid = new Uuid();
    var tx = Transaction(
      title: txtitle,
      amount: txamount,
      date: transcationDate,
      id: uuid.v1(),
    );
    setState(() {
      _userTransactions.add(tx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  bool _showChart = false;
  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (builderCtx) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mQuerObj = MediaQuery.of(context);
    final bool isLandscape =
        mQuerObj.orientation == Orientation.landscape;
    final appBarWidget = AppBar(
      title: Text('Expense Planner App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddTransaction(context),
        ),
      ],
    );
    final txListWidget = Container(
      height: (mQuerObj.size.height -
              mQuerObj.padding.top -
              appBarWidget.preferredSize.height) *
          0.9,
      child: TransactionList(_userTransactions, _deleteTransaction, isLandscape),
    );
    final anotxListWidget = Container(
      height: (mQuerObj.size.height -
              mQuerObj.padding.top -
              appBarWidget.preferredSize.height) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction, isLandscape),
    );
    return Scaffold(
      appBar: appBarWidget,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
            if (!isLandscape)
              Container(
                height: (mQuerObj.size.height -
                        mQuerObj.padding.top -
                        appBarWidget.preferredSize.height) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) anotxListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mQuerObj.size.height -
                              mQuerObj.padding.top -
                              appBarWidget.preferredSize.height) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddTransaction(context),
      ),
    );
  }
}

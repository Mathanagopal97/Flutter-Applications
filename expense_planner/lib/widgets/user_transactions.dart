import '../models/transaction.dart';

import './new_transactions.dart';
import './transactions_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      amount: 100.99,
      title: 'Shoes',
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      amount: 200.99,
      title: 'Grocery',
      date: DateTime.now(),
    ),
  ];
  void _addNewTransaction(String txtitle, double txamount) {
    var tx = Transaction(
      title: txtitle,
      amount: txamount,
      date: DateTime.now(),
      id: DateTime.now().toIso8601String(),
    );
    setState(() {
       _userTransactions.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions,_addNewTransaction, true),
      ],
    );
  }
}

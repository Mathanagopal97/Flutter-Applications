import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Result extends StatelessWidget {
  final int _totalScore;
  final Function handleRestart;
  Result(this._totalScore,this.handleRestart);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            'Completed!!! Your score is $_totalScore',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(child: Text('Restart Game'),onPressed: handleRestart,)
        ],
      ),
    );
  }
}

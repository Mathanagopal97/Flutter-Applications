import 'package:flutter/material.dart';

class Answers extends StatelessWidget {
  final Function handleClick;
  final String answer;
  Answers(this.handleClick,this.answer);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(answer),
        onPressed: handleClick,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './quiz.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var _qNumber = 0;
  var _totalScore = 0;
  var _question = [
    {
      'questionText': 'What is your favourite color?',
      'answer': [
        {'text': 'Black', 'score': 2},
        {'text': 'Red', 'score': 12},
        {'text': 'Green', 'score': 20},
        {'text': 'Yellow', 'score': 14}
      ],
    },
    {
      'questionText': 'What is your favourite animal?',
      'answer': [
        {'text': 'Lion', 'score': 20},
        {'text': 'Zebra', 'score': 12},
        {'text': 'Deer', 'score': 14},
        {'text': 'Snake', 'score': 2}
      ],
    },
    {
      'questionText': 'What is your favourite pet?',
      'answer': [
        {'text': 'Dog', 'score': 20},
        {'text': 'Cat', 'score': 14},
        {'text': 'Parrot', 'score': 12},
        {'text': 'Rat', 'score': 2}
      ],
    },
  ];
  void _answerQuestion(int score) {
    setState(() {
      _qNumber = _qNumber + 1;
    });
    _totalScore += score;
    if (_qNumber < _question.length) {
      //var theQuestion = _question[_qNumber]['questionText'];
      print('Pressed Something.... $_qNumber. Changing the question.');
    } else {
      print('No more questions. Your score is $_totalScore');
    }
  }

  void _restartGame() {
    setState(() {
      _qNumber = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First app'),
        ),
        body: _qNumber < _question.length
            ? Quiz(
                answerQuestionFun: _answerQuestion,
                qNumber: _qNumber,
                questionList: _question,
              )
            : Result(_totalScore,_restartGame),
      ),
    );
  }
}

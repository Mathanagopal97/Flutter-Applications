import 'package:flutter/material.dart';

import './question.dart';
import './answers.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questionList;
  final int qNumber;
  final Function answerQuestionFun;
  Quiz({this.questionList,this.qNumber,this.answerQuestionFun});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Questions(questionList[qNumber]['questionText']),
        ...(questionList[qNumber]['answer'] as List<Map<String,Object>>).map((answer) {
          return Answers(() => answerQuestionFun(answer['score']), answer['text']);
        }).toList()
      ],
    );
  }
}

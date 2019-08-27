import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final amountController = TextEditingController();
  final titleController = TextEditingController();
  final Function addTx;
  NewTransaction(this.addTx);

  void handleSubmit() {
    final enteredTitle = titleController.text;
    final enteredamount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredamount <= 0){
      return;
    }
      addTx(
        enteredTitle,
        enteredamount,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => handleSubmit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => handleSubmit(),
            ),
            FlatButton(
              child: Text(
                'Add transaction',
                style: TextStyle(color: Colors.purple),
              ),
              onPressed: () => handleSubmit(),
            ),
          ],
        ),
      ),
    );
  }
}

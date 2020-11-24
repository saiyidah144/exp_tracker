import 'package:exp_tracker/Category.dart';
import 'package:flutter/material.dart';
import 'package:exp_tracker/Expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'providerWidget.dart';
import 'package:intl/intl.dart';

class NewExpenseSummaryView extends StatelessWidget {
  final db = Firestore.instance;
  final Expense expense;

  NewExpenseSummaryView({Key key, @required this.expense}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    final expenseTypes = expense.types();
    var expenseKeys = expenseTypes.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${expense.amount}"),
            Text("${DateFormat('dd/MM/yyyy').format(expense.date).toString()}"),
            Expanded(child: GridView.count(
                crossAxisCount: 3,
                scrollDirection: Axis.vertical,
                primary: false,
              children: List.generate(expenseTypes.length, (index) {
                  return FlatButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        expenseTypes[expenseKeys[index]],
                        Text(expenseKeys[index]),
                        ],
                   ),
              onPressed: () async {
                expense.type = expenseKeys[index];
                final uid = await Provider.of(context).auth.getCurrentUID();
                await db.collection("userData").document(uid).collection("expenses").add(expense.toJson());
                Navigator.of(context).popUntil((route) => route.isFirst);
              });
          }),
            ),
            )
          ],
        ),
      ),
    );
  }
}

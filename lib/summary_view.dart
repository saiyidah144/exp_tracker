import 'package:exp_tracker/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:exp_tracker/Expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'providerWidget.dart';
import 'package:intl/intl.dart';

class NewExpenseSummaryView extends StatelessWidget {
  final db = Firestore.instance;
  final Expense expense;
  final primaryColor = const Color(0xFFCE93D8);
  NewExpenseSummaryView({Key key, @required this.expense}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    final expenseTypes = expense.types();
    var expenseKeys = expenseTypes.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("RM${expense.amount}",
              style: TextStyle(fontSize: 25),),
              Text("${DateFormat('dd/MMMM/yyyy').format(expense.date).toString()}",
              style: TextStyle(fontSize: 25),),
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
      ),
    );
  }
}

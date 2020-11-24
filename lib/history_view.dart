import 'package:exp_tracker/providerWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:exp_tracker/Expense.dart';


class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: getUsersTripsStreamSnapshots(context),
          builder: (context, snapshot) {
            if(!snapshot.hasData ) return const Text("Loading...");
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildExpenseCard(context, snapshot.data.documents[index]));
          }
      ),
    );
  }
  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('expenses').orderBy('date', descending: true).snapshots();
  }
  Widget buildExpenseCard(BuildContext context, DocumentSnapshot document) {
    final expense = Expense.fromSnapshot(document);
    final expenseType = expense.types();

    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text(expense.type, style: new TextStyle(fontSize: 30.0),),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                  child: Row(children: <Widget>[
                    Text(
                        "${DateFormat('dd/MM/yyyy').format(expense.date).toString()}"),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text("\$${(expense.amount == null)? "n/a" : expense.amount.toStringAsFixed(2)}", style: new TextStyle(fontSize: 35.0),),
                      Spacer(),
                      (expenseType.containsKey(expense.type))? expenseType[expense.type]: expenseType["other"],
                    ],
                  ),)]),
        ),
      ),
    );
  }
}

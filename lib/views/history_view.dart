import 'package:exp_tracker/models/providerWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:exp_tracker/models/Expense.dart';


class HistoryPage extends StatelessWidget {
  final doc = Firestore.instance;
  final Expense expense;

   HistoryPage({Key key, this.expense}) : super(key: key);

  createAlertDialog (BuildContext context, DocumentSnapshot document){
    final expense = Expense.fromSnapshot(document);
    DateTime _dateTime1 = DateTime.now();

    TextEditingController _expenseController = new TextEditingController();
    return showDialog(context: context, builder: (context){
      return  AlertDialog(
          title: Text("Edit Expense"),
          content:  Column(
                  children: <Widget>[
                    Text("New Amount"),
                    TextField(
                      controller: _expenseController,
                    ),
                  ],
                ),

          actions: <Widget>[
            FlatButton(
                child: Text("Update"),
                onPressed: () async {
                  final doc = Firestore.instance;
                  expense.updDate = _dateTime1;
               expense.amount = double.parse(_expenseController.text);
               var uid = await Provider.of(context).auth.getCurrentUID();
               await doc.collection("userData").document(uid).collection("expenses").document(expense.documentId).setData(expense.toJson());

            //   await updateExpense(context);
               Navigator.of(context).pop();
                }),
            FlatButton(
              child: Text("Delete"),
              onPressed: () async {
                final doc = Firestore.instance;
                expense.amount = double.parse(_expenseController.text);
                var uid = await Provider.of(context).auth.getCurrentUID();
                await doc.collection("userData").document(uid).collection("expenses").document(expense.documentId).delete();
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

              },
            ),
          ],
        );
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController _typeController = new TextEditingController();
    return  Column(
      children: <Widget>[
        Container(
          child: Card(
            child: TextField(
              controller: _typeController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        Expanded(
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
        ),
      ],
    );
  }
  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('expenses').orderBy('date', descending: true).snapshots();
  }
  Widget buildExpenseCard(BuildContext context, DocumentSnapshot document) {
    final expense = Expense.fromSnapshot(document);
    final expenseType = expense.types();
    final primaryColor = const Color(0xFFFFECB3);

    return new Container(
      color: primaryColor,
      child: Column(
        children: <Widget>[
          Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                        child: Row(children: <Widget>[
                          Text(expense.type, style: new TextStyle(fontSize: 30.0),),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              createAlertDialog(context,document);
                            },
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                        child: Row(children: <Widget>[
                          Text(
                              "Created : ${DateFormat('dd/MM/yyyy').format(expense.date).toString()}"),
                          Spacer(),

                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 25.0),
                        child: Row(
                          children: <Widget>[
                            Text("Updated : ${DateFormat('dd/MM/yyyy').format(expense.date).toString()}"),
                            Spacer(),
                          ],
                        ),),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Text("\$RM${(expense.amount == null)? "n/a" : expense.amount.toStringAsFixed(2)}", style: new TextStyle(fontSize: 35.0),),
                            Spacer(),
                            (expenseType.containsKey(expense.type))? expenseType[expense.type]: expenseType["other"],
                          ],
                        ),)
                    ]),
              ),
          ),
        ],
      ),
    );
  }



}

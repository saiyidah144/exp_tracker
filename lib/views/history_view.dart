import 'package:exp_tracker/models/category_data.dart';
import 'package:exp_tracker/services/firestore_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class Categories {
  double budget;
  double expenses;
  String date;
  String type;

  Categories(this.budget, this.expenses,this.date,this.type);
}

class HistoryPage extends StatelessWidget {
  final doc = Firestore.instance;
  final Category category;

   HistoryPage({Key key, this.category}) : super(key: key);



  createAlertDialog (BuildContext context, DocumentSnapshot document){
    final category = Category.fromSnapshot(document);
    DateTime _dateTime1 = DateTime.now();

    TextEditingController _expenseController = new TextEditingController();
    TextEditingController _budgetController = new TextEditingController();

    return showDialog(context: context, builder: (context){
      return  AlertDialog(
          title: Text("Edit Expense"),
          content:  new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Text(category.type),
              TextField(controller: _expenseController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "Update Expenses",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),

              TextField(controller: _budgetController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "Update Budget",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),

            ],
          ),
          ),

        /*  Column(
                  children: <Widget>[
                    Text(category.type),
                    Text("New Expenses"),
                    TextField(controller: _expenseController,),
                    Text("New Budget"),
                    TextField(controller: _budgetController,),
                    Text("Date"),
                    TextField(controller: _dateController,),

                  ],
                ), */

          actions: <Widget>[
            FlatButton(
                child: Text("Update"),
                onPressed: () async {
                  Category categories = Category(
                    expenses: double.parse(_expenseController.text),
                    budget: double.parse(_budgetController.text),
                    date:_dateTime1,
                    type: category.type,
                    id: category.id,
                  );
                  await FirestoreService().updateData(categories);
                  Navigator.pop(context);

            //   await updateExpense(context);
                }),
            
          ],
        );
    }
    );
  }
  void _deleteData(BuildContext context,String id) async {
    if(await _showConfirmationDialog(context)) {
      try {
        await FirestoreService().deleteData(id);
      }catch(e) {
        print(e);
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          content: Text("Are you sure you want to delete?"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.red,
              child: Text("Delete"),
              onPressed: () => Navigator.pop(context,true),
            ),
            FlatButton(
              textColor: Colors.black,
              child: Text("No"),
              onPressed: () => Navigator.pop(context,false),
            ),
          ],
        )
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
       //   Expanded(
      //    child: new ListView.builder(
      //        itemCount: category.length,
       //       itemBuilder: (BuildContext context, int index) => buildExpenseCard(context, index)
      //  ),
      //    ),
        Expanded(
          child: StreamBuilder(
              stream: Firestore.instance.collection('Category').snapshots(),
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


  Widget buildExpenseCard(BuildContext context, DocumentSnapshot document) {
    final category = Category.fromSnapshot(document);


    final primaryColor = const Color(0xFFFFECB3);

    return new Container(
      color: primaryColor,
      child: Column(
        children: <Widget>[
          Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                        child: Row(children: <Widget>[
                          Text(category.type,  style: new TextStyle(fontSize: 30.0),),
                          Spacer(),
                          IconButton(icon: Icon(Icons.delete),
                              onPressed: (){
                                _deleteData(context, category.id);
                              })
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                        child: Row(children: <Widget>[
                          Text("Date : ${DateFormat('dd/MM/yyyy').format(category.date).toString()}",  style: new TextStyle(fontSize: 15.0),),
                          Spacer(),
                          IconButton(icon: Icon(Icons.edit),
                              onPressed: (){
                            createAlertDialog(context, document);
                              })
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Text("\$RM${(category.expenses == null)? "n/a" : category.expenses.toStringAsFixed(2)}", style: new TextStyle(fontSize: 20.0),),
                            Spacer(),
                            Text("\$RM${(category.budget == null)? "n/a" : category.budget.toStringAsFixed(2)}", style: new TextStyle(fontSize: 20.0),),
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

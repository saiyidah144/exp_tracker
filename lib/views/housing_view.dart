import 'package:flutter/material.dart';
import 'package:exp_tracker/models/category_data.dart';
import 'package:exp_tracker/models/providerWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HousingRoute extends StatefulWidget {
  final Category housing;
  //final Expense expense;

  const HousingRoute({Key key, this.housing}) : super(key: key);
  @override
  _HousingRouteState createState() => _HousingRouteState();
}

class _HousingRouteState extends State<HousingRoute> {
  final db = Firestore.instance;
//  Expense expense;
  Category housing;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _budgetController;
  TextEditingController _expensesController;
  TextEditingController _dateController;


  @override
  void initState() {
    super.initState();
    _budgetController =
        TextEditingController(text:  '');
    _expensesController =
        TextEditingController(text: '');
    _dateController =
        TextEditingController(text: '');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE7F6),
      appBar: AppBar(
        backgroundColor: Color(0xFF8E24AA),
        title: const Text('Housing', style: TextStyle(fontSize: 30)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Image(image: null,),
              const SizedBox(height: 50.0),
              TextFormField(
                textInputAction: TextInputAction.next,

                controller: _budgetController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Budget field cannot be empty";
                  return null;
                },

                decoration: InputDecoration(

                  labelText: "Budget(RM)",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(

                controller: _expensesController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Expenses field cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Expenses(RM)",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(

                controller: _dateController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Date field cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Date(DD/MM/YY)",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),

              new Center(child:RaisedButton(
                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Colors.green)
                ),
                padding: const EdgeInsets.all(15.0),
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Save", style: new TextStyle(fontSize: 20.0, color: Colors.white),),

                onPressed: () async {
                  if (_key.currentState.validate()) {
                    try {
                      final uid = await Provider.of(context).auth.getCurrentUID();
                      await db.collection("userData").document(uid).collection("expense").document(uid).collection("housing").add(housing.toJson());


                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),),
            ],
          ),
        ),
      ),
    );
  }
}






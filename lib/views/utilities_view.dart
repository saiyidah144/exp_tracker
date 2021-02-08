import 'package:exp_tracker/models/category_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp_tracker/models/providerWidget.dart';
import 'package:intl/intl.dart';



class UtilitiesRoute extends StatefulWidget {
  final Category utilities;
 // final Expense expense;

  const  UtilitiesRoute({Key key, this.utilities}) : super(key: key);
  @override
  _UtilitiesRouteState createState() => _UtilitiesRouteState();
}

class _UtilitiesRouteState extends State< UtilitiesRoute> {
  final db = Firestore.instance;
 // Expense expense;
  DateTime _dateTime = DateTime.now();
  Category utilities;
  var _expenseTotal = 0.0;
  var _budgetTotal = 0.0;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _budgetController = new TextEditingController();
  TextEditingController _expensesController  = new TextEditingController();
 // TextEditingController _dateController  = new TextEditingController();


  @override
  void initState() {
    super.initState();
    _expensesController.addListener(_setExpenseTotal);
    _budgetController.addListener(_setBudgetTotal);
  //  _dateController = TextEditingController(text: '');

  }
  _setExpenseTotal(){
    setState(() {
      _expenseTotal = ((_expensesController.text == "") ? 0.0 : double.parse(_expensesController.text));
    });
  }
  _setBudgetTotal(){
    setState(() {
      _budgetTotal = ((_budgetController.text == "") ? 0.0 : double.parse(_budgetController.text));
    });
  }
  Future displayDateRangePicker (BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: new DateTime(2015),
        lastDate: new DateTime(2026));
    if (picked !=null && picked != _dateTime ){
      setState(() {
        _dateTime = picked;
        DateFormat('dd/MMMM/yyyy').format(_dateTime).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE7F6),
      appBar: AppBar(
        backgroundColor: Color(0xFF8E24AA),
        title: const Text('Utilities', style: TextStyle(fontSize: 30)),
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
              RaisedButton (
                child: Text("Select Date"),
                  onPressed: () async {
                    displayDateRangePicker(context);
                  } ),
              Text("Date : ${DateFormat('MM/dd/yyyy').format(_dateTime).toString()}"),
          //    TextFormField(

          //      controller: _dateController,
          //      validator: (value) {
          //        if (value == null || value.isEmpty)
           //         return "Date field cannot be empty";
           //       return null;
          //      },
           //     decoration: InputDecoration(
           //       labelText: "Date(DD/MM/YY)",
          //        labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
          //        border: OutlineInputBorder(),
           //     ),
           //   ),
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
                      utilities.expenses = _expenseTotal.toDouble();
                      utilities.date = _dateTime as String;
                      utilities.budget = _budgetTotal.toDouble();
                      final uid = await Provider.of(context).auth.getCurrentUID();
                      await db.collection("userData").document(uid).collection("expense").document(uid).collection("utilities").add(utilities.toJson());

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
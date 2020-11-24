import 'package:exp_tracker/Category.dart';
import 'package:exp_tracker/providerWidget.dart';
import 'package:exp_tracker/summary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'dart:async';
import 'package:intl/intl.dart';

class NewExpenseView extends StatefulWidget {
  final Expense expense;
  NewExpenseView({Key key, @required this.expense}) : super(key: key);

  @override
  _NewExpenseViewState createState() => _NewExpenseViewState();
}

class _NewExpenseViewState extends State<NewExpenseView> {
  Expense expense;
  final db = Firestore.instance;
  DateTime _dateTime = DateTime.now();
  var _expenseTotal = 0;
  TextEditingController _expenseController = new TextEditingController();

Future displayDateRangePicker (BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context, 
        initialDate: _dateTime,
        firstDate: new DateTime(2015),
        lastDate: new DateTime(2026));
    if (picked !=null && picked != _dateTime ){
      setState(() {
        _dateTime = picked;
      });
    }
}

@override
void initState(){
  super.initState();
  _expenseController.addListener(_setExpenseTotal);
}

_setExpenseTotal(){
  setState(() {
    _expenseTotal = int.parse (_expenseController.text);
  });
}

List<Widget> setExpenseFields (_budgetController) {
  List<Widget> fields = [];


  fields.add(Padding(padding: const EdgeInsets.only(top: 12.0),
  child: Text("Enter Amount"),
  ));
  fields.add(generateTextField (_expenseController, "Amount spending"));

  fields.add(RaisedButton(
      child: Text("Select Date"),
      onPressed: () async {
  await displayDateRangePicker(context);
  },),);

  fields.add(Text("Date : ${DateFormat('MM/dd/yyyy').format(_dateTime).toString()}"),);

  fields.add(FlatButton(
    child: Text("Continue",
    style: TextStyle(fontSize: 16, color: Colors.orange),),
      onPressed: () async {
      widget.expense.amount = _expenseTotal.toDouble();
      widget.expense.date = _dateTime;
      Navigator.push(context, MaterialPageRoute(builder: (context) => NewExpenseSummaryView(expense: widget.expense,)),
      );
      },
    ));
  return fields;
}
  @override
  Widget build(BuildContext context) {



_expenseController.text = (_expenseController.text) == "0" ? "" : _expenseTotal.toString();
_expenseController.selection = TextSelection.collapsed(offset: _expenseController.text.length);


    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: ListView(
        children: setExpenseFields(_expenseController),
      )
        






    );
  }
  Widget generateTextField (controller, helperText) {
    Widget textField = Padding(padding: const EdgeInsets.all(30.0),
      child: TextField(
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(
          helperText: helperText,
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        autofocus: true,
      ),
    );
    return textField;
  }
}




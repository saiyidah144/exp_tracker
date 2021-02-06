import 'package:exp_tracker/money_text_field.dart';
import 'package:exp_tracker/summary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class NewExpenseView extends StatefulWidget {
  final Expense expense;
  NewExpenseView({Key key, @required this.expense}) : super(key: key);

  @override
  _NewExpenseViewState createState() => _NewExpenseViewState();
}

class _NewExpenseViewState extends State<NewExpenseView> {
  final primaryColor = const Color(0xFFCE93D8);
  Expense expense;
  final db = Firestore.instance;
  DateTime _dateTime = DateTime.now();
  var _expenseTotal = 0.0;
  TextEditingController _expenseController = new TextEditingController();


@override
void initState(){
  super.initState();
  _expenseController.addListener(_setExpenseTotal);
}

_setExpenseTotal(){
  setState(() {
    _expenseTotal = ((_expenseController.text == "") ? 0.0 : double.parse(_expenseController.text)) ;
  });
}

List<Widget> setExpenseFields (_budgetController) {
  List<Widget> fields = [];


  fields.add(Center(
    child: Padding(padding: const EdgeInsets.only(top: 12.0),
    child: Text("Enter Amount"),
    ),
  ));
  fields.add(MoneyTextField (controller: _expenseController, helperText: "Amount spending"));

  /*fields.add(RaisedButton(
      child: Text("Select Date"),
      onPressed: () async {
  await displayDateRangePicker(context);
  },),);
*/
  fields.add(Center
    (child: Text(" Date : ${DateFormat('dd/MMMM/yyyy').format(_dateTime).toString()}")),
  );

  fields.add(FlatButton(
    child: Text("Continue",
    style: TextStyle(fontSize: 16, color: Colors.orange),),
      onPressed: () async {
      widget.expense.amount = _expenseTotal;
      widget.expense.date = _dateTime;
      Navigator.push(context, MaterialPageRoute(builder: (context) => NewExpenseSummaryView(expense: widget.expense,)),
      );
      },
    ));
  return fields;
}
  @override
  Widget build(BuildContext context) {



_expenseController.text = (_expenseController.text) == "0" ? "" : _expenseTotal.toStringAsFixed(0);
_expenseController.selection = TextSelection.collapsed(offset: _expenseController.text.length);


    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
        backgroundColor: primaryColor,
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
        keyboardType: TextInputType.number,
        inputFormatters: [
          ThousandsFormatter(allowFraction: true)
        ],
        autofocus: true,
      ),
    );
    return textField;
  }
}




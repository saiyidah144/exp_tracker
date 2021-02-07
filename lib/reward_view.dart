import 'package:flutter/material.dart';
import 'package:exp_tracker/Expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp_tracker/providerWidget.dart';


class RewardView extends StatefulWidget {
  final Expense expense;


  const RewardView({Key key, this.expense}) : super(key: key);

  @override
  _RewardViewState createState() => _RewardViewState();
}

class _RewardViewState extends State<RewardView> {
  final primaryColor = const Color(0xFFCE93D8);
  final db = Firestore.instance;
  Expense expense;
  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime(2021,1,30);
  bool _isRewardOn = false;
  Icon rewardOff = Icon(Icons.lock, size: 80,);
  Icon rewardOn = Icon(Icons.lock_open, size: 80,);
  external int get day;


  @override
  Widget build(BuildContext context)  {

    return Scaffold(
      appBar: AppBar(
        title: Text('Reward'),
        backgroundColor: primaryColor,
      ),
      body:Column(
          children: <Widget>[
            new Container(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: new Column(
                  children: <Widget>[
                    Text('This is Reward Page', style: TextStyle(fontSize: 25),),
                    Text('You can unlock the reward by fulfilling the whole month spending'),
                  ],
                ),
              ),
            ),
            Container(
            child: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 100.0, right: 4.0),
              child: GestureDetector(
                  child: Container(
                      child: _isRewardOn ? rewardOn : rewardOff),
                    onTap: () async {
                          final uid = await Provider.of(context).auth.getCurrentUID();
                          final user =  db.collection("userData").document(uid).collection("expenses").reference();
                          final dates = db.collection("userData").document(uid).collection("expenses").where("date").reference();
                        setState(() {
                          while ( date1.day != 15 ) {
                            if (  user != null ) {
                              // ignore: unrelated_type_equality_checks
                              if ( dates == day ) {
                                _isRewardOn = !_isRewardOn;
                                // ignore: unrelated_type_equality_checks
                                if (rewardOff == 5){
                                  showAlertDialog(context);
                                }
                                else{
                                  Text("Please Complete 5 lock");
                                }
                              }
                              else{
                                Text("Please Complete 5 lock");
                              }
                            }
                            else {
                              _isRewardOn = _isRewardOn;

                            }
                          }


                          });
                    },
              ),
            ),
          ),
    ])

    );

  }
showAlertDialog (BuildContext context){
  // set up the buttons

  Widget closeButton = FlatButton(
    child: Text("Close"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text("Your code is ajsadhsd"),
    actions: [
      closeButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


}








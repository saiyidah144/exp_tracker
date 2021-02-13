import 'package:exp_tracker/models/category_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// TO VIEW REWARD PAGE
class RewardView extends StatefulWidget {
  final Category category;


  const RewardView({Key key, this.category}) : super(key: key);

  @override
  _RewardViewState createState() => _RewardViewState();
}

class _RewardViewState extends State<RewardView> {
  final primaryColor = const Color(0xFFCE93D8);
  final db = Firestore.instance;
  Category category;
  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime(2021,1,30);
  bool _isRewardOn1 = false;
  bool _isRewardOn2 = false;
  bool _isRewardOn3 = false;
  bool _isRewardOn4 = false;
  bool _isRewardOn5 = false;
  bool _isRewardOn6 = false;
  bool _isRewardOn7 = false;
  bool _isRewardOn8 = false;
  bool _isRewardOn9 = false;
  bool _isRewardOn10 = false;
  Icon rewardOff1 = Icon(Icons.lock, size: 80,);
  Icon rewardOff2 = Icon(Icons.lock, size: 80,);
  Icon rewardOff3 = Icon(Icons.lock, size: 80,);
  Icon rewardOff4 = Icon(Icons.lock, size: 80,);
  Icon rewardOff5 = Icon(Icons.lock, size: 80,);
  Icon rewardOff6 = Icon(Icons.lock, size: 80,);
  Icon rewardOff7 = Icon(Icons.lock, size: 80,);
  Icon rewardOff8 = Icon(Icons.lock, size: 80,);
  Icon rewardOff9 = Icon(Icons.lock, size: 80,);
  Icon rewardOff10 = Icon(Icons.lock, size: 80,);
  Icon rewardOn1 = Icon(Icons.lock_open, size: 80,);
  Icon rewardOn2 = Icon(Icons.lock_open, size: 80,);
  Icon rewardOn3 = Icon(Icons.lock_open, size: 80,);
  Icon rewardOn4 = Icon(Icons.lock_open, size: 80,);
  Icon rewardOn5 = Icon(Icons.lock_open, size: 80,);
  Icon rewardOn6 = Icon(Icons.lock_open, size: 80,);
  Icon rewardOn7 = Icon(Icons.lock_open, size: 80,);
  Icon rewardOn8 = Icon(Icons.lock_open, size: 80,);
  Icon rewardOn9 = Icon(Icons.lock_open, size: 80,);
  Icon rewardOn10 = Icon(Icons.lock_open, size: 80,);

  external int get day;


  @override
  Widget build(BuildContext context)  {

    return Scaffold(
      appBar: AppBar(
        title: Text('Reward'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              new Container(
                color: Colors.deepPurple[100],
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: new Column(
                    children: <Widget>[
                      Text('Welcome, ', style: TextStyle(fontSize: 40, ),),
                      Text('You can unlock the lock by fulfilling the whole month spending'),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.deepPurple[200],
                child: Padding(
                  padding: const EdgeInsets.all(31),
                  child: new Column(
                    children: <Widget>[
                      Text("Reward Lock for First 5 Months", style: TextStyle(fontSize: 25, ),),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.deepPurple[100],
              child: Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 20.0, right: 4.0),
                child: GestureDetector(
                    child: Container(
                        child: Column(
                          children: <Widget>[

                            Padding(padding: EdgeInsets.all(0),
                            child: Row(
                             children: <Widget>[

                               _isRewardOn1 ? rewardOn1 : rewardOff1,
                               _isRewardOn2 ? rewardOn2 : rewardOff2,
                               _isRewardOn3 ? rewardOn3 : rewardOff3,
                               _isRewardOn4 ? rewardOn4 : rewardOff4,
                               _isRewardOn5 ? rewardOn5 : rewardOff5,
                             ],
                            ),),

                          ],
                        )
                    ),

                      onTap: () async {
                            final category = Firestore.instance.collection('Category').reference();
                          setState(() {
                       //     while ( date1.day != 15 ) {
                              if (  category != null ) {
                                _isRewardOn1 = !_isRewardOn1;
                                showAlertDialog(context);
                              }
                       //     }


                            }
                            );
                      },
                ),
              ),
            ),
              Container(
                color: Colors.deepPurple[200],
                child: Padding(
                  padding: const EdgeInsets.all(31),
                  child: new Column(
                    children: <Widget>[
                      Text("Reward Lock for First 5 Months", style: TextStyle(fontSize: 25, ),),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.deepPurple[100],
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 20.0, right: 4.0),
                  child: GestureDetector(
                    child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(0),
                              child: Row(
                                children: <Widget>[
                                  _isRewardOn6 ? rewardOn6 : rewardOff6,
                                  _isRewardOn7 ? rewardOn7 : rewardOff7,
                                  _isRewardOn8 ? rewardOn8 : rewardOff8,
                                  _isRewardOn9 ? rewardOn9 : rewardOff9,
                                  _isRewardOn10 ? rewardOn10 : rewardOff10,
                                ],
                              ),),

                          ],
                        )
                    ),

                    onTap: () async {
                      final category = Firestore.instance.collection('Category').reference();

                      setState(() {
                        //     while ( date1.day != 15 ) {
                        if (  category != null ) {
                          _isRewardOn1 = !_isRewardOn1;
                          showAlertDialog(context);
                        }
                        //     }


                      }
                      );
                    },
                  ),
                ),
              ),
    ]),
      )

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








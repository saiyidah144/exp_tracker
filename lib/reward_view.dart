import 'package:flutter/material.dart';
import 'package:exp_tracker/Expense.dart';

class RewardView extends StatelessWidget {

  final primaryColor = const Color(0xFFCE93D8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reward'),
        backgroundColor: primaryColor,
      ),
      body:

      RewardWidget(),

    );

  }
}

class RewardWidget extends StatefulWidget {
  @override
  _RewardWidgetState createState() => _RewardWidgetState();
}

class _RewardWidgetState extends State<RewardWidget> {

  bool _isRewardOn = false;
  Icon RewardOff = Icon(Icons.lock, size: 80,);
  Icon RewardOn = Icon(Icons.lock_open, size: 80,);

  @override
  Widget build(BuildContext context ) {
    return  new Scaffold(
      body: Column(
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
                       child: _isRewardOn ? RewardOn : RewardOff),
                   onTap: () {
                     setState(() {
                    //   if (Expense.fromSnapshot(snapshot).amount != null ) {
                         _isRewardOn = !_isRewardOn;
                     //  }
                     //  else {
                     //    _isRewardOn = _isRewardOn;
                       //}
                     });
                   },

               ),
             ),
      ),

    ])
    );


   // Ada 5 lock
    // lock 1,2,3,4,5
    // onchange ataupun state
    //bila expense.month is fullfilled
    // generate code

  }


}




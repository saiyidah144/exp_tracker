import 'package:flutter/material.dart';

class RewardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reward'),
      ),
      body:

      RewardWidget(),

    );

  }
}

class RewardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      body: new Container(
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
    );


   // Ada 5 lock
    // lock 1,2,3,4,5
    // onchange ataupun state
    //bila expense.month is fullfilled
    // generate code

  }

}
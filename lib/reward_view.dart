import 'package:flutter/material.dart';

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

class RewardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
               child: Row(
                 children: <Widget>[
                   Lock(),
                   Lock(),
                   Lock(),
                   Lock(),
                   Lock(),
                 ],
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

class Lock extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 100.0, left: 20.0),
      child: IconButton(
        icon: Icon(Icons.lock, size: 80,),
        onPressed: () {
          Icon(Icons.lock_open);
        },
      ),

    );
  }
}

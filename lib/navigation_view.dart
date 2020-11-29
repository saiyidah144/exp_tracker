import 'package:exp_tracker/Expense.dart';
import 'package:exp_tracker/reward_view.dart';
import 'package:flutter/material.dart';
import 'package:exp_tracker/expense_view.dart';
import 'history_view.dart';
import 'pages.dart';
import 'package:exp_tracker/profile_view.dart';



class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home>{
  final primaryColor = const Color(0xFFCE93D8);
  int _currentIndex=0;
  final List<Widget> _children = [
    HomeView(),
    HistoryPage(),
    StatisticsPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
final newExpense = new Expense(null,null,null);

    return Scaffold(
      appBar: AppBar(
        title: Text("EXPTracker"),
        backgroundColor: primaryColor,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),

              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewExpenseView(expense : newExpense, )),);
              }, ),
        ],
      ),
      body: _children[_currentIndex],
      floatingActionButton: FloatingActionButton (
      child: Icon(Icons.card_giftcard),
        backgroundColor: primaryColor,
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RewardView()));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(

          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items:[
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.history),
              title: new Text("History"),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.equalizer),
              title: new Text("Statistics"),
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text("Account"),
              backgroundColor: primaryColor,
            ),
          ]
      ),
    );
  }

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}
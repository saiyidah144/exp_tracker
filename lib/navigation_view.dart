import 'package:exp_tracker/Expense.dart';
import 'package:exp_tracker/reward_view.dart';
import 'package:flutter/material.dart';
import 'package:exp_tracker/expense_view.dart';
import 'history_view.dart';
import 'pages.dart';
import 'auth_service.dart';
import 'providerWidget.dart';
import 'package:exp_tracker/profile_view.dart';



class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home>{

  int _currentIndex=0;
  final List<Widget> _children = [
    HomeView(),
    HistoryPage(),
    StatisticsPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
final newExpense = new Expense(null, null, null,);
    return Scaffold(
      appBar: AppBar(
        title: Text("EXPTracker"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),
              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewExpenseView(expense : newExpense, )),);
              }, ),
   /*   IconButton(
        icon: Icon(Icons.undo),
        onPressed: () async {
          try {
            AuthService auth = Provider.of(context).auth;
            await auth.signOut();
            print("Signed Out!");
          } catch (e) {
            print (e);
          }
        },
          ),
      IconButton(
        icon: Icon(Icons.account_circle),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
          },
      ), */
        ],
      ),
      body: _children[_currentIndex],
      floatingActionButton: FloatingActionButton (
      child: Icon(Icons.card_giftcard),
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
              backgroundColor: Colors.amber,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.history),
              title: new Text("History"),
              backgroundColor: Colors.amber,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.equalizer),
              title: new Text("Statistics"),
              backgroundColor: Colors.amber,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text("Account"),
              backgroundColor: Colors.amber,
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
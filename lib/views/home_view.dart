import 'package:exp_tracker/views/adhoc_view.dart';
import 'package:exp_tracker/views/discretionary_view.dart';
import 'package:exp_tracker/views/food_view.dart';
import 'package:exp_tracker/views/health_view.dart';
import 'package:exp_tracker/views/housing_view.dart';
import 'package:exp_tracker/views/personal_care_view.dart';
import 'package:exp_tracker/views/savings_view.dart';
import 'package:exp_tracker/views/social_participation_view.dart';
import 'package:exp_tracker/views/transport_view.dart';
import 'package:exp_tracker/views/utilities_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE7F6),

      //appBar: AppBar(
      // backgroundColor: Color(0xFF8E24AA),
      //title: const Text('Food', style: TextStyle(fontSize: 30)),
      //),
      body:
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const ListTile(
              title: Text('Welcome,',style: TextStyle(fontSize: 30)),
              subtitle: Text('Click on each icon to choose categories to track your expenses',style: TextStyle(fontSize: 20)),
            ),

            GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[

                new Container(

                  child: RaisedButton(
                      child: Icon(Icons.fastfood, size: 80),

                      color: Colors.deepPurple[100],

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FoodRoute()),
                        );
                      }

                  ),
                ),
                new Container(

                  child: RaisedButton(
                      child: Icon(Icons.home, size: 80),
                      color: Colors.deepPurple[200],

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HousingRoute ()),
                        );
                      }

                  ),
                ),
                new Container(

                  child: RaisedButton(
                      child: Icon(Icons.healing, size: 80),
                      color: Colors.deepPurple[200],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HealthRoute()),
                        );
                      }

                  ),
                ),
                new Container(

                  child: RaisedButton(
                      child: Icon(Icons.account_balance_wallet, size: 80),
                      color: Colors.deepPurple[100],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SavingsRoute()),
                        );
                      }
                  ),
                ),
                new Container(

                  child: RaisedButton(
                      child: Icon(Icons.shopping_cart, size: 80),
                      color: Colors.deepPurple[100],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>DiscretionaryExpensesRoute()),
                        );
                      }
                  ),
                ),
                new Container(

                  child: RaisedButton(
                      child: Icon(Icons.directions_car, size: 80),
                      color: Colors.deepPurple[200],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TransportRoute()),
                        );
                      }

                  ),
                ),
                new Container(

                  child: RaisedButton(
                      child: Icon(Icons.build, size: 80),
                      color: Colors.deepPurple[200],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UtilitiesRoute()),
                        );
                      }

                  ),
                ),
                new Container(

                  child: RaisedButton(
                      child: Icon(Icons.lightbulb_outline, size: 80),
                      color: Colors.deepPurple[100],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PersonalCareRoute()),
                        );
                      }

                  ),
                ),
                new Container(

                  child: RaisedButton(
                      child: Icon(Icons.people_outline, size: 80),
                      color: Colors.deepPurple[100],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SocialParticipationRoute()),
                        );
                      }
                  ),
                ),
                new Container(

                  child: RaisedButton(
                      child: Icon(Icons.monetization_on, size: 80),
                      color: Colors.deepPurple[200],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdHocOneOffRoute()),
                        );
                      }
                  ),
                ),
              ],
            ),
          ],),),);
  }
}

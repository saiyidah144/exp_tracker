import 'package:exp_tracker/models/UserProfile.dart';
import 'package:exp_tracker/views/add_profile.dart';
import 'package:exp_tracker/views/detailed_profile_view.dart';
import 'package:flutter/material.dart';
import '../models/providerWidget.dart';


// TO VIEW THE USER PROFILE PAGE, AND ADD/UPDATE USER DATA, AND SIGN OUT
class AccountPage extends StatefulWidget{
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  UserProfile userProfile;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                FutureBuilder(
                  future: Provider.of(context).auth.getCurrentUser(),
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.done){
                      return displayUserInformation(context, snapshot);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget displayUserInformation(context, snapshot){
    final authData = snapshot.data;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Card(
        color: Colors.deepPurple[50],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4.0,bottom: 8.0),
                child: Text(
                  "USERNAME : ${authData.displayName ?? 'Anonymous'}",
                  style: TextStyle(fontSize: 20),),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5.0,bottom: 9.0),
                child: Text(" EMAIL : ${authData.email ?? 'Anonymous'}",
                  style: TextStyle(fontSize: 20),),
              ),


              showSignOut(context, authData.isAnonymous),
              RaisedButton(
                padding: const EdgeInsets.only(right: 25.0, left: 25.0, top: 8.0, bottom: 8.0),
                child: Text("A D D  U S E R  I N F O R M A T I O N"),
                textColor: Colors.white,
                color:  Colors.deepPurple[400],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProfileInformation()),
                  );
                },
              ),
              Text("NOTE : ABOVE IS FOR FIRST TIME ADD USER INFORMATION ONLY ", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),textAlign: TextAlign.center,),
              RaisedButton(
                  padding: const EdgeInsets.only(right: 25.0, left: 25.0, top: 8.0, bottom: 8.0),
                  child: Text("V I E W  D E T A I L E D  I N F O R M A T I O N"),
                  textColor: Colors.white,
                  color: Colors.deepPurple[700],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailedProfileView()),
                    );
                  })
            ],
          ),
      ),
    );
  }



  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return RaisedButton(
        child: Text("Sign In To Save Your Data"),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
        },
      );
    } else {
      return RaisedButton(
        padding: const EdgeInsets.only(right: 25.0, left: 25.0, top: 8.0, bottom: 8.0),
        child: Text("S I G N   O U T"),
        textColor: Colors.white,
        color: Colors.red[500],
        onPressed: () async {
          try {
            await Provider.of(context).auth.signOut();
          } catch (e) {
            print(e);
          }
        },
      );
    }
  }

  // createProfileDialog(BuildContext context, DocumentSnapshot document) {
  //   final userProfile = UserProfile.fromSnapshot(document);
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext bc) {
  //       return AlertDialog(
  //        title: Text("Update Profile"),
  //         content: Padding(
  //           padding: const EdgeInsets.only(left: 4.0,),
  //           child: SingleChildScrollView(
  //             child: Column(
  //               children: <Widget>[
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: Container(
  //                         child: Column(
  //                           children: <Widget>[
  //                             Padding(
  //                               padding: const EdgeInsets.only(right: 15.0),
  //                               child: TextField(
  //                                 decoration: InputDecoration(
  //                                   helperText: "Name",
  //                                 ),
  //                                 controller: _nameController,
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(right: 15.0),
  //                               child: TextField(
  //                                 controller: _ageController,
  //                                 decoration: InputDecoration(
  //                                   helperText: "Age",
  //                                 ),
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(right: 15.0),
  //                               child: TextField(
  //                                 controller: _genderController,
  //                                 decoration: InputDecoration(
  //                                   helperText: "Gender",
  //                                 ),
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(right: 15.0),
  //                               child: TextField(
  //                                 controller: _ethnicityController,
  //                                 decoration: InputDecoration(
  //                                   helperText: "Ethnicity",
  //                                 ),
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(right: 15.0),
  //                               child: TextField(
  //                                 controller: _phoneNoController,
  //                                 decoration: InputDecoration(
  //                                   helperText: "Telephone No ",
  //                                 ),
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(right: 15.0),
  //                               child: TextField(
  //                                 controller: _locationController,
  //                                 decoration: InputDecoration(
  //                                   helperText: "Location",
  //                                 ),
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(right: 15.0),
  //                               child: TextField(
  //                                 controller: _houseCategoryController,
  //                                 decoration: InputDecoration(
  //                                   helperText: "Household Category",
  //                                 ),
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(right: 15.0),
  //                               child: TextField(
  //                                 controller: _shortController,
  //                                 decoration: InputDecoration(
  //                                   helperText: "Short Term Category",
  //                                 ),
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(right: 15.0),
  //                               child: TextField(
  //                                 controller: _longController,
  //                                 decoration: InputDecoration(
  //                                   helperText: "Long Term Category",
  //                                 ),
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(right: 15.0),
  //                               child: TextField(
  //                                 controller: _incomeController,
  //                                 decoration: InputDecoration(
  //                                   helperText: "Net Income ",
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //
  //                     )
  //                   ],
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: <Widget>[
  //                     RaisedButton(
  //                       child: Text('Save'),
  //                       color: Colors.green,
  //                       textColor: Colors.white,
  //                       onPressed: () async {
  //                           UserProfile up = UserProfile(
  //                           name: _nameController.text,
  //                           age: int.parse(_ageController.text),
  //                           gender: _genderController.text,
  //                           ethnic: _ethnicityController.text,
  //                           phoneNo: _phoneNoController.text,
  //                           location: _locationController.text,
  //                           houseCategory: _houseCategoryController.text,
  //                           shortTarget: double.parse(_shortController.text),
  //                           longTarget: double.parse(_longController.text),
  //                           netIncome: double.parse(_incomeController.text),
  //                           id: userProfile.id,
  //                           );
  //                           await FirestoreService().addProfile(up);
  //                           Navigator.pop(context);
  //                           })
  //       ]),
  //                     ])
  //                 ),
  //             ),
  //       );
  //    },
  //  );
 // }
}
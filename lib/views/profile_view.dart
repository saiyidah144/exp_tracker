import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp_tracker/models/UserProfile.dart';
import 'package:exp_tracker/views/add_profile.dart';
import 'package:flutter/material.dart';
import '../models/providerWidget.dart';



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
                Expanded(
                  child: StreamBuilder(
                      stream: Firestore.instance.collection('userData').snapshots(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData ) return const Text("Loading...");
                        return new ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) =>
                               buildUserInformationCard(context, snapshot.data.documents[index]));
                      }
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
Widget buildUserInformationCard (BuildContext context, DocumentSnapshot document){
  final userProfile = UserProfile.fromSnapshot(document);
  return Container(
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Row(children: <Widget>[
            Text(userProfile.name,  style: new TextStyle(fontSize: 15.0),),
            Spacer(),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Row(children: <Widget>[
            Text(userProfile.age.toString(),  style: new TextStyle(fontSize: 15.0),),
            Spacer(),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Row(children: <Widget>[
            Text(userProfile.gender,  style: new TextStyle(fontSize: 15.0),),
            Spacer(),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Row(children: <Widget>[
            Text(userProfile.ethnic,  style: new TextStyle(fontSize: 15.0),),
            Spacer(),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Row(children: <Widget>[
            Text(userProfile.phoneNo,  style: new TextStyle(fontSize: 15.0),),
            Spacer(),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Row(children: <Widget>[
            Text(userProfile.location,  style: new TextStyle(fontSize: 15.0),),
            Spacer(),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Row(children: <Widget>[
            Text(userProfile.houseCategory,  style: new TextStyle(fontSize: 15.0),),
            Spacer(),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Row(children: <Widget>[
            Text(userProfile.shortTarget.toString(),  style: new TextStyle(fontSize: 15.0),),
            Spacer(),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Row(children: <Widget>[
            Text(userProfile.longTarget.toString(),  style: new TextStyle(fontSize: 15.0),),
            Spacer(),
          ]),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4.0,bottom: 8.0),
                child: Text(
                  "Username: ${authData.displayName ?? 'Anonymous'}",
                  style: TextStyle(fontSize: 20),),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5.0,bottom: 9.0),
                child: Text("Email: ${authData.email ?? 'Anonymous'}",
                  style: TextStyle(fontSize: 20),),
              ),


              showSignOut(context, authData.isAnonymous),
              RaisedButton(
                child: Text("Update Information"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProfileInformation()),
                  );
                },
              )
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
        child: Text("Sign Out"),
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
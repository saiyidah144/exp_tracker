import 'package:exp_tracker/UserProfile.dart';
import 'package:flutter/material.dart';
import 'providerWidget.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget{
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  UserProfile userProfile = UserProfile ("",null,"", "","","","",null,null,null);
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  TextEditingController _genderController = new TextEditingController();
  TextEditingController _ethnicityController = new TextEditingController();
  TextEditingController _phoneNoController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();
  TextEditingController _houseCategoryController = new TextEditingController();
  TextEditingController _shortController = new TextEditingController();
  TextEditingController _longController = new TextEditingController();
  TextEditingController _incomeController = new TextEditingController();

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
                )
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

              FutureBuilder(
                  future: _getProfileData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      _nameController.text = userProfile.name;
                      _ageController.text = userProfile.age.toString();
                      _genderController.text = userProfile.gender;
                      _ethnicityController.text = userProfile.ethnic;
                      _phoneNoController.text = userProfile.phoneNo;
                      _locationController.text = userProfile.location;
                      _houseCategoryController.text = userProfile.houseCategory;
                      _shortController.text = userProfile.shortTarget.toString();
                      _longController.text = userProfile.longTarget.toString();
                      _incomeController.text = userProfile.netIncome.toString();
                    }
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0,bottom: 9.0),
                            child: Text(
                              "Name: ${_nameController.text}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 7.0,bottom: 10.0),
                          child: Text("Age : ${_ageController.text}",
                            style: TextStyle(fontSize: 20),
                          ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 8.0,bottom: 11.0),
                            child: Text("Gender : ${_genderController.text}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 9.0,bottom: 12.0),
                            child: Text("Ethnicity : ${_ethnicityController.text}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 10.0,bottom: 13.0),
                            child: Text("Telephone No : ${_phoneNoController.text}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 11.0,bottom: 14.0),
                            child: Text("Location : ${_locationController.text}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 12.0,bottom: 15.0),
                            child: Text("Household Category : ${_houseCategoryController.text}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 13.0,bottom: 16.0),
                            child: Text("Short Term Target : ${_shortController.text}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 14.0,bottom: 17.0),
                            child: Text("Long Term Target : ${_longController.text}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(top: 15.0,bottom: 18.0),
                            child: Text("Net Income : ${_incomeController.text}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
              showSignOut(context, authData.isAnonymous),
              RaisedButton(
                child: Text("Edit User"),
                onPressed: () {
                  createProfileDialog(context);
                },
              )
            ],
          ),
      ),
    );
  }
  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context).db.collection('userData').document(uid).get().then((result){
      userProfile.name = result.data['name'];
      userProfile.age = result.data['age'];
      userProfile.gender = result.data['gender'];
      userProfile.ethnic = result.data['ethnic'];
      userProfile.phoneNo = result.data['phoneNo'];
      userProfile.location = result.data['location'];
      userProfile.houseCategory = result.data['houseCategory'];
      userProfile.shortTarget = result.data['shortTarget'];
      userProfile.longTarget = result.data['longTarget'];
      userProfile.netIncome = result.data['netIncome'];
    });
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

  createProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext bc) {
        return AlertDialog(
         title: Text("Update Profile"),
          content: Padding(
            padding: const EdgeInsets.only(left: 4.0,),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    helperText: "Name",
                                  ),
                                  controller: _nameController,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _ageController,
                                  decoration: InputDecoration(
                                    helperText: "Age",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _genderController,
                                  decoration: InputDecoration(
                                    helperText: "Gender",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _ethnicityController,
                                  decoration: InputDecoration(
                                    helperText: "Ethnicity",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _phoneNoController,
                                  decoration: InputDecoration(
                                    helperText: "Telephone No ",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _locationController,
                                  decoration: InputDecoration(
                                    helperText: "Location",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _houseCategoryController,
                                  decoration: InputDecoration(
                                    helperText: "Household Category",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _shortController,
                                  decoration: InputDecoration(
                                    helperText: "Short Term Category",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _longController,
                                  decoration: InputDecoration(
                                    helperText: "Long Term Category",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _incomeController,
                                  decoration: InputDecoration(
                                    helperText: "Net Income ",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Save'),
                        color: Colors.green,
                        textColor: Colors.white,
                        onPressed: () async {
                          userProfile.name = _nameController.text;
                          userProfile.age = int.parse(_ageController.text);
                          userProfile.gender = _genderController.text;
                          userProfile.ethnic = _ethnicityController.text;
                          userProfile.phoneNo = _phoneNoController.text;
                          userProfile.location = _locationController.text;
                          userProfile.houseCategory = _houseCategoryController.text;
                          userProfile.shortTarget = double.parse(_shortController.text);
                          userProfile.longTarget = double.parse(_longController.text);
                          userProfile.netIncome = double.parse(_incomeController.text);

                          setState(() {
                            _nameController.text = userProfile.name;
                            _ageController.text = userProfile.age.toString();
                            _genderController.text =  userProfile.gender;
                            _ethnicityController.text = userProfile.ethnic;
                            _phoneNoController.text = userProfile.phoneNo;
                            _locationController.text = userProfile.location;
                            _houseCategoryController.text =  userProfile.houseCategory;
                            _shortController.text = userProfile.shortTarget.toStringAsFixed(2);
                            _longController.text = userProfile.longTarget.toStringAsFixed(2);
                            _incomeController.text =  userProfile.netIncome.toStringAsFixed(2);
                          });
                          final uid =
                          await Provider.of(context).auth.getCurrentUID();
                          await Provider.of(context).db.collection('userData').document(uid).collection('userProfile')
                              .setData(userProfile.toJson());
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
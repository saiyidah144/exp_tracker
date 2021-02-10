import 'package:exp_tracker/models/UserProfile.dart';
import 'package:exp_tracker/services/firestore_service.dart';
import 'package:flutter/material.dart';

class AddProfileInformation extends StatefulWidget {
  final UserProfile userProfile;

  const AddProfileInformation({Key key, this.userProfile}) : super(key: key);
  @override
  _AddProfileInformationState createState() => _AddProfileInformationState();
}

class _AddProfileInformationState extends State<AddProfileInformation> {
  UserProfile userProfile;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
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
    return Scaffold(
      backgroundColor: Color(0xFFEDE7F6),
      appBar: AppBar(
        backgroundColor: Color(0xFF8E24AA),
        title: const Text('Ad Hoc/One-off', style: TextStyle(fontSize: 30)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Image(image: null,),
              const SizedBox(height: 50.0),
              TextFormField(
                textInputAction: TextInputAction.next,

                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Name field cannot be empty";
                  return null;
                },

                decoration: InputDecoration(

                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _ageController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Age field cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Age",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _genderController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Gender field cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Gender",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _ethnicityController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Ethnicity field cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Ethnicity",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _phoneNoController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Phone no field cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Phone No",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _locationController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Location field cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Location",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _houseCategoryController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "House Category field cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "House Category",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _shortController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Short term goal field cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Short Term Goal",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _longController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Long term goal field cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Long Term Goal",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _incomeController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Net Income field cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Net Income",
                  labelStyle: TextStyle(color: Colors.black, fontSize:20.0),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),

              new Center(child:RaisedButton(
                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Colors.green)
                ),
                padding: const EdgeInsets.all(15.0),
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Save", style: new TextStyle(fontSize: 20.0, color: Colors.white),),

                onPressed: () async {
                  if (_key.currentState.validate()) {
                    try {
                      UserProfile up = UserProfile(
                        name: _nameController.text,
                      age: int.parse(_ageController.text),
                      gender: _genderController.text,
                      ethnic: _ethnicityController.text,
                      phoneNo: _phoneNoController.text,
                      location: _locationController.text,
                      houseCategory: _houseCategoryController.text,
                      shortTarget: double.parse(_shortController.text),
                      longTarget: double.parse(_longController.text),


                      );
                      await FirestoreService().addProfile(up);

                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
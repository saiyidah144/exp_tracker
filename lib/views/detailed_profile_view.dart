import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp_tracker/models/UserProfile.dart';
import 'package:exp_tracker/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// TO VIEW DETAILED USER PROFILE AND UPDATE THE DATA IN USER PROFILE
// ignore: must_be_immutable
class DetailedProfileView extends StatelessWidget {
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
  final primaryColor = const Color(0xFFCE93D8);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: primaryColor,
       title: Text("Detailed User Information"),
     ),
     body: Container(
       color: Colors.deepPurple[50],
       child: ListView(
         padding: EdgeInsets.all(8),
         children: <Widget> [
         StreamBuilder<QuerySnapshot>(
           stream: Firestore.instance.collection('userData').snapshots(),
             builder: (context,snapshot){
              if (snapshot.hasData){
                return Column(
                  children: snapshot.data.documents.map((doc) => buildUserInformationCard(context,doc)).toList());
              } else {
                return SizedBox();
              }
             }),

    ],
       ),
     ),


   );
  }

  Widget buildUserInformationCard ( BuildContext context, DocumentSnapshot doc){
    final userProfile = UserProfile.fromSnapshot(doc);
    return Card(
      child: Padding(padding: const EdgeInsets.all(8.0),
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text("Name : ", style: new TextStyle(fontSize: 25.0),),
                Spacer(),
                Text(userProfile.name,  style: new TextStyle(fontSize: 25.0),),
              ],
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text("Age : ", style: new TextStyle(fontSize: 25.0),),
                Spacer(),
                Text(userProfile.age.toString(), style: new TextStyle(fontSize: 25.0),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text("Gender : ", style: new TextStyle(fontSize: 25.0),),
                Spacer(),
                Text(userProfile.gender, style: new TextStyle(fontSize: 25.0),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text("Ethnicity : ", style: new TextStyle(fontSize: 25.0),),
                Spacer(),
                Text(userProfile.ethnic.toString(), style: new TextStyle(fontSize: 25.0),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text("Phone No : ", style: new TextStyle(fontSize: 25.0),),
                Spacer(),
                Text(userProfile.phoneNo, style: new TextStyle(fontSize: 25.0),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text("House Location : ", style: new TextStyle(fontSize: 25.0),),
                Spacer(),
                Text(userProfile.location, style: new TextStyle(fontSize: 25.0),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text("Household Category : ", style: new TextStyle(fontSize: 25.0),),
                Spacer(),
                Text(userProfile.houseCategory, style: new TextStyle(fontSize: 25.0),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                  Text("Short Term Goal : ", style: new TextStyle(fontSize: 25.0),),
                Spacer(),
                Text(userProfile.shortTarget.toString(), style: new TextStyle(fontSize: 25.0),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text("Long Term Goal : ", style: new TextStyle(fontSize: 25.0),),
                Spacer(),
                Text(userProfile.longTarget.toString(), style: new TextStyle(fontSize: 25.0),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text("Net Income : ", style: new TextStyle(fontSize: 25.0),),
                Spacer(),
                Text(userProfile.netIncome.toString(), style: new TextStyle(fontSize: 25.0),),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    textColor: Colors.black54,
                    color:  Colors.deepPurple[200],
                    child: Text("Update Data", style: new TextStyle(fontSize: 25.0),),
                    onPressed: () async {
                      updateProfileInformation(context,doc);
                    }),
              ],
            ),
          ),
        ],
        ),

      ),
    );
  }
  updateProfileInformation(BuildContext context, DocumentSnapshot snapshot){
    final userProfile = UserProfile.fromSnapshot(snapshot);
   return showDialog(context: context, builder:(context) {
     return AlertDialog(
       title: Text("Update User Information"),
       content: Padding(padding: const EdgeInsets.all(0),
       child:  Container(
         width: MediaQuery.of(context).size.width,
         child: SingleChildScrollView(
          // padding: const EdgeInsets.all(30.0),
           child: Form(
             key: _key,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 // Image(image: null,),
                 const SizedBox(height: 10.0),
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
                   keyboardType: TextInputType.numberWithOptions(decimal: false),
                   inputFormatters: [
                     WhitelistingTextInputFormatter.digitsOnly,
                   ],
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
                   keyboardType: TextInputType.numberWithOptions(decimal: false),
                   inputFormatters: [
                     WhitelistingTextInputFormatter.digitsOnly,
                   ],
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
                   keyboardType: TextInputType.numberWithOptions(decimal: false),
                   inputFormatters: [
                     WhitelistingTextInputFormatter.digitsOnly,
                   ],
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
                   keyboardType: TextInputType.numberWithOptions(decimal: false),
                   inputFormatters: [
                     WhitelistingTextInputFormatter.digitsOnly,
                   ],
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
                   keyboardType: TextInputType.numberWithOptions(decimal: false),
                   inputFormatters: [
                     WhitelistingTextInputFormatter.digitsOnly,
                   ],
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
                           netIncome: double.parse(_incomeController.text),
                           id: userProfile.id,
                         );
                         await FirestoreService().updateProfile(up);
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
       ),
       ),
     );
   }
   );
  }
}

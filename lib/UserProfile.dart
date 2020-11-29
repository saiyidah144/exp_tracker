
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  String name; // Name
  int age;
  String gender;
  String ethnic; //Ethnicity
  String phoneNo;
  String location;
  String houseCategory;// Household Category
  double shortTarget; //short term target
  double longTarget; // long term target
  double netIncome; // net disposable income input

  UserProfile (this.name, this.age, this.gender, this.ethnic, this.phoneNo, this.location, this.houseCategory,
    this.shortTarget, this.longTarget, this.netIncome);

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'age': age,
        'gender' : gender,
        'ethnic' : ethnic,
        'phoneNo' : phoneNo,
        'location' : location,
        'houseCategory' : houseCategory,
        'shortTarget' : shortTarget,
        'longTarget' : longTarget,
        'netIncome' : netIncome,
      };

/*  UserProfile.fromSnapshot (DocumentSnapshot snapshot):
        name = snapshot['name'],
        age = snapshot['age'],
        gender = snapshot['gender'],
        ethnic = snapshot['ethnic'],
        phoneNo = snapshot['phoneNo'],
        location = snapshot['location'],
        houseCategory = snapshot['houseCategory'],
        shortTarget = snapshot['shortTarget'],
        longTarget = snapshot['longTarget'],
        netIncome = snapshot['netIncome']; */

}


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Expense {
  double amount;
  DateTime date;
  String type;
  String documentId;
  DateTime updDate;


  Expense(this.amount, this.date, this.type, );

  Map<String, dynamic> toJson() =>
      {
        'amount': amount,
        'date': date,
        'type' : type,
        'updDate' : updDate,
      };

Expense.fromSnapshot (DocumentSnapshot snapshot):
    amount = snapshot['amount'],
    date = snapshot['date'].toDate(),
    type = snapshot['type'],
      documentId = snapshot.documentID;


  Map<String, Icon> types() =>
      {
        "Food": Icon(Icons.fastfood, size: 50),
        "Transportation": Icon(Icons.directions_bus, size: 50),
        "House": Icon(Icons.home, size: 50),
        "Utilities": Icon(Icons.build, size: 50),
        "Personal_care": Icon(Icons.lightbulb_outline, size: 50),
        "Health": Icon(Icons.healing, size: 50),
        "Social_participation": Icon(Icons.people, size: 50),
        "Discretionary_expenses": Icon(Icons.shopping_cart, size: 50),
        "other": Icon(Icons.directions, size: 50),
      };

}
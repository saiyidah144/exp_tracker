
import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
   double budget;
   double expenses;
   String date;
  String documentId;

  Category(this.budget, this.expenses,this.date);

  Map<String, dynamic> toJson() =>
      {
        "Budget" : budget,
        "Expenses":expenses,
        "Date":date,
      };

  Category.fromSnapshot (DocumentSnapshot snapshot):
        budget = snapshot['budget'],
        date = snapshot['date'].toDate(),
        expenses = snapshot['expenses'],
        documentId = snapshot.documentID;


}
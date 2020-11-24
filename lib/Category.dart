
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String Type;

Category (this.Type);

  Map<String, dynamic> toJson() =>
      {
        'Type': Type,
      };

  Category.fromSnapshot(DocumentSnapshot snapshot) :
        Type = snapshot['Type'];


}
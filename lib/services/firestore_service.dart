import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exp_tracker/models/category_data.dart';
import 'package:exp_tracker/models/UserProfile.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
  FirestoreService._internal();
  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Future <void> addData(Category category) {
    return _db.collection('Category').add(category.toMap());
  }
  Future <void> updateData(Category category) {
    return _db.collection('Category').document(category.id).updateData(category.toMap());
  }
  Future<void> deleteData(String id) {
    return _db.collection('Category').document(id).delete();
  }
  Future <void> addProfile(UserProfile userProfile) {
    return _db.collection('userData').add(userProfile.toMap());
  }
  Future <void> updateProfile(UserProfile userProfile) {
    return _db.collection('userData').document(userProfile.id).updateData(userProfile.toMap());
  }


  /*
  Future <void> addHealth(Category health ) {
    return _db.collection('Category').add(health.toMap());
  }
  Future <void> addTransport(Category transport ) {
    return _db.collection('Category').add(transport.toMap());
  }
  Future <void> addUtilities(Category utilities ) {
    return _db.collection('Category').add(utilities.toMap());
  }
  Future <void> addSavings(Category savings ) {
    return _db.collection('Category').add(savings.toMap());
  }
  Future <void> addCare(Category care ) {
    return _db.collection('Category').add(care.toMap());
  }
  Future <void> addAdhoc(Category adhoc) {
    return _db.collection('Category').add(adhoc.toMap());
  }
  Future <void> addDiscretionary(Category discretionary ) {
    return _db.collection('Category').add(discretionary.toMap());
  }
  Future <void> addSocial(Category social ) {
    return _db.collection('Category').add(social.toMap());
  } */
// Future<void> deleteSocial(String id) {
//   return _db.collection('social').document(id).delete();
// }
}
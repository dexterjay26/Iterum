import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
FirebaseFirestore firestore = FirebaseFirestore.instance;

class UserHelper {
  Future<void> createUser({
    String id,
    String name,
    String number,
    String address,
    String email,
    String photoUrl,
    String birthDate,
  }) async {
    Map<String, dynamic> values = {
      'id': id,
      'name': name,
      'number': number,
      'email': email,
      'birthDate': birthDate,
      'address': address,
      'photoUrl': photoUrl
    };

    await users
        .doc(id)
        .set(values)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<bool> getUserById(String id) async {
    final documentSnapshot = await firestore.collection('users').doc(id).get();

    if (documentSnapshot.exists) {
      return true;
    }

    return false;
  }
}

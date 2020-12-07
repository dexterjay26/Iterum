import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
CollectionReference helpRequest =
    FirebaseFirestore.instance.collection('help_request');

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

  Future<QuerySnapshot> fetchNeedsHelp() async {
    final querySnapshot = await firestore
        .collection('help_request')
        .where('responded', isEqualTo: false)
        .get();

    if (querySnapshot != null) {
      return querySnapshot;
    }
    print('NO DATA');

    return null;
  }

  Future<bool> respondHelp(String id, String respondingID) async { // responds to help na, we can put some thing here too
    var help = false;
    await helpRequest
        .doc(id)
        .update({'responded': true, 'responding': respondingID}).then((value) {
      print("Response Updated");
      help = true;
    }).catchError((error) {
      print("Failed to update user: $error");
      help = false;
    });

    return help;
  }

  Future<bool> hasResponding(String id) async {
    final documentSnapshot = await firestore.collection('help_request').doc(id).get();
    final responded = await documentSnapshot.data()['responded'];
    if(responded){
      return true;
    }

    return false;
  }

  Future<bool> sendHelp(
      {String id,
      double lat,
      double lng,
      String number,
      String name,
      String fcmToken}) async {
    final documentSnapshot = await firestore.collection('users').doc(id).get();

    Map<String, dynamic> values = {
      'id': id,
      'name': name,
      'number': await documentSnapshot.data()['number'],
      'lat': lat,
      'lng': lng,
      'date-req': DateTime.now().toIso8601String(),
      'responded': false,
      'responding': '',
    };

    await helpRequest.doc(id).set(values).then((value) {
      print("Help Requested");
      return true;
    }).catchError((error) => print("Failed to request help: $error"));

    return false;
  }
}

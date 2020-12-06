import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/messaging.dart';
import '../helpers/user_helper.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;
  bool _hasAccount;
  bool _hasResponding = false;

  bool get hasResponding => _hasResponding;

  QuerySnapshot markerSnapshot;

  //QuerySnapshot get markerSnapshot => _markerSnapshot;

  UserCredential _userCredential;
  final userHelper = UserHelper();
  CollectionReference reference =
      FirebaseFirestore.instance.collection('help_request');

  CollectionReference userReference =
      FirebaseFirestore.instance.collection('help_request');

  GoogleSignInProvider() {
    _isSigningIn = false;

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    reference.snapshots().listen(
      (querySnapshot) {
        querySnapshot.docChanges.forEach((change) async {
          await fetchNeedsHelp();
          notifyListeners();
        });
      },
    );
  }

  Future fetchNeedsHelp() async {
    final querySnapshot = await userHelper.fetchNeedsHelp();
    markerSnapshot = querySnapshot;
  }

  bool get isSigningIn => _isSigningIn;
  bool get hasAccount => _hasAccount;

  UserCredential get userCredentials => _userCredential;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredentials =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final hasAccount = await userHelper.getUserById(userCredentials.user.uid);

      if (hasAccount) {
        _hasAccount = true;
      } else {
        _hasAccount = false;
      }
      _userCredential = userCredentials;
      isSigningIn = false;

      notifyListeners();
    }
  }

  Future<void> respondHelp(String id) async {
    await userHelper.respondHelp(id, userCredentials.user.uid);
    notifyListeners();
  }

  Future<void> sendHelp({double lat, double lng}) async {
    await userHelper.sendHelp(
      id: userCredentials.user.uid,
      lat: lat,
      lng: lng,
      name: userCredentials.user.displayName,
      number: userCredentials.user.phoneNumber,
    );

    await _sendNotification(
        title: 'Someone Needs Help! Respond Quickly',
        body: 'Cellphone number: ${userCredentials.user.phoneNumber}');
  }

  Future _sendNotification({String title, String body}) async {
    try {
      final response = await Messaging.sendToAll(
        title: title,
        body: body,
        // fcmToken: fcmToken,
      );

      if (response.statusCode != 200) {
        print('dohot binaligtad');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> skipSetup({
    String id,
    String name,
    String email,
    String number = '',
    String photoUrl,
  }) async {
    await createUser(
      id: id,
      name: name,
      email: email,
      number: number,
      imgUrl: photoUrl,
      address: '',
      birthDate: '',
    );
    _hasAccount = true;
    notifyListeners();
  }

  Future<DocumentSnapshot> getUserSnapShot() async {
    final documentSnapshot = await firestore
        .collection('help_request')
        .doc(userCredentials.user.uid)
        .get();
    return documentSnapshot;
  }

  Future<void> createUser({
    String id,
    String name,
    String email,
    String number,
    String birthDate,
    String address,
    String imgUrl,
  }) async {
    await userHelper.createUser(
      id: id,
      name: name,
      email: email,
      number: number,
      address: address,
      photoUrl: imgUrl,
    );
    _hasAccount = true;
    notifyListeners();
  }

  void isResponding(BuildContext context) async {
    final documentSnapshot = await firestore
        .collection('help_request')
        .doc(userCredentials.user.uid)
        .get();

    bool isResponded = await documentSnapshot.data()['responded'];

    if (isResponded) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Respond!!!"),
          content: Container(
            width: 300,
            child: Text('There is someone going there. Stay alive!'),
          ),
          actions: [
            FlatButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
              },
              child: Text('Done'),
            )
          ],
        ),
      );
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';
import '../helpers/user_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/messaging.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
          // Do something with change
          print('================================');
          print('================================');
          print('Somethinmg CHANGED');
          print('================================');
          print('================================');
          print(change.doc.id);
          print(change.doc.data()['id']);

          // if (change.doc.id == userCredentials.user.uid) {
          //   print('NAPASOK DITO');
          //   final isResponding = await userHelper.hasResponding(change.doc.id);

          //   if (isResponding) {
          //     _hasResponding = true;
          //     notifyListeners();
          //     return;
          //   }

          //   _hasResponding = false;
          //   notifyListeners();
          //   return;
          // } else {
          await fetchNeedsHelp();
          notifyListeners();
        });
      },
    );

    // userReference.snapshots().listen(
    //   (querySnapshot) {
    //     querySnapshot.docChanges.forEach((change) async {
    //       //await fetchNeedsHelp();
    //       notifyListeners();
    //     });
    //   },
    // );
  }

  Future fetchNeedsHelp() async {
    final querySnapshot = await userHelper.fetchNeedsHelp();

    markerSnapshot = querySnapshot;

    // querySnapshot.docs.forEach(
    //   (value) {
    //     _markers.add(
    //       Marker(
    //         markerId: MarkerId(
    //           value.data()['id'],
    //         ),
    //         position: LatLng(
    //           value.data()['lat'],
    //           value.data()['lng'],
    //         ),
    //         onTap: () {
    //           print("${value.data()['id']} IM PRESSED");
    //         },
    //       ),
    //     );
    //},
    //);
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
        //Do something - go login
        _hasAccount = true;
      } else {
        _hasAccount = false;
        //Do something - go sign up
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

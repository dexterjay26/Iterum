import '../screens/pin_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/otp_screen.dart';
import '../main.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
}

class Auth with ChangeNotifier {
  static const collection = "users";

  String _id;
  String _number;

  String smsOTP;
  String verificationId;
  String errorMessage = '';
  bool loggedIn;
  bool loading = false;
  String token;
  bool _hasPin;

  Status _status = Status.Uninitialized;

  final verificationController = TextEditingController();

  //final _firestore = Firestore.instance;
  //final _auth = FirebaseAuth.instance;

  FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;

  //FirebaseUser _user;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String get id => _id;
  String get number => _number;
  Status get status => _status;
  bool get hasPin => _hasPin;

  Auth.initialize() {
    readPrefs();
  }

  Future<void> readPrefs() async {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        _status = Status.Unauthenticated;
        notifyListeners();
      } else {
        print("Signed In");

        _id = user.uid;
        _number = user.phoneNumber;

        _status = Status.Authenticated;
        notifyListeners();
      }
    });
  }

  Future<void> _authenticate(
      BuildContext context, AuthCredential phoneAuthCredential) async {
    print('_AUTHENTICATE METHOD');
    //final AuthResult user = await _auth.signInWithCredential(phoneAuthCredential);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
    final User currentUser = userCredential.user;

    assert(userCredential.user.uid == currentUser.uid);

    //final availUser =

    if (userCredential.user.uid != null) {
      //get the user
      await _getUserById(
        context: context,
        id: userCredential.user.uid,
        number: userCredential.user.phoneNumber,
      );

      print("there is a user");

      _status = Status.Authenticated;
      notifyListeners();
    }
  }

  Future<void> verifyPhoneNumber(BuildContext context, String number) async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      //Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => OTPScreen()));
      _showVerifyDialog(context);
    };

    try {
      await auth.verifyPhoneNumber(
          phoneNumber: number.trim(), // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          },
          codeSent: smsOTPSent, // WHEN CODE SENT THEN OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) async {
            //_authenticate(context, phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            print('${exceptio.message} + something is wrong');
          });
    } catch (e) {
      print("DITO NAG ERROR SA VERIFY PHOINE");
      //errorMessage = e.toString();
      //notifyListeners();
    }
  }

  Future<void> setPin(String pin) async {
    await users.doc(_id).update({'pin': pin}).then((value) {
      print("User Updated");
      _hasPin = true;
      notifyListeners();
    }).catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> _createUser({String id, String number}) async {
    print('=================================');
    print('CREATE USER METHOD');
    print('=================================');
    Map<String, dynamic> values = {
      'id': id,
      'number': number,
      'pin': '',
    };

    await users
        .doc(id)
        .set(values)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    _hasPin = false;
  }

  Future<void> _getUserById({
    BuildContext context,
    String id,
    String number,
  }) async {
    print('=================================');
    print('GET USER METHOD');
    print('=================================');

    try {
      final documentSnapshot = await firestore
          .collection('users')
          .doc(id)
          .get(); // get the user, if null must create new user

      if (documentSnapshot.exists) {
        _id = documentSnapshot.data()['id'];
        _number = documentSnapshot.data()['number'];
      } else {
        await _createUser(id: id, number: number);
        _hasPin = false; // creates user
      }
    } catch (e) {
      print("PROBLEM PROBLEM PROBLEM");
      print(e.toString());
    }
  }

  Future<void> signIn(BuildContext context) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      //print(verificationId);
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );

      await _authenticate(context, credential);
    } catch (e) {
      print("${e.toString()}");
    }
  }

  Future<void> _showVerifyDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Verify "),
        content: Container(
          width: 300,
          child: TextField(
            controller: verificationController,
            maxLength: 6,
            decoration: InputDecoration(labelText: 'Verification Code'),
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () async {
              smsOTP = verificationController.text;
              Navigator.of(ctx).pop();
              await signIn(context);
            },
            child: Text('Done'),
          )
        ],
      ),
    );
  }

  Future signOut(BuildContext context) async {
    await auth.signOut();
    _status = Status.Uninitialized;

    //notifyListeners();
    _id = null;
    _number = null;
    _hasPin = null;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => FastAid(),
      ),
    );

    //return Future.delayed(Duration.zero);
  }
}

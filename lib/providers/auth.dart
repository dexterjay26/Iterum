import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/mobile_auth_screen.dart';
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

  Auth.initialize() {
    readPrefs();
  }

  Future<void> readPrefs() async {
    // If there is an account that is currently logged in.
    await Future.delayed(Duration(seconds: 3)).then((v) async {
      //firestore = FirebaseFirestore.instance;
      final prefs = await SharedPreferences.getInstance();
      try {
        final userData = await json.decode(prefs.getString('userData'))
            as Map<String, dynamic>;

        if (userData.containsKey('userData') || userData != null) {
          print('this is also triggerd');
          _id = userData['id'];
          _number = userData['number'];

          user = auth.currentUser;

          loggedIn = true;

          print("There is a currently logged in user");

          //_userModel = await _userServicse.getUserById(_user.uid);
          _status = Status.Authenticated;
          notifyListeners();
          return;
        }
      } catch (e) {
        await prefs.clear().then((value) {
          if (value) {
            print("CLEARED");
          }
        });
      }

      _status = Status.Unauthenticated;
      notifyListeners();
      return;
    });

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('=================================');
        print('\n User is currently signed out! \n');
        print('=================================');
      } else {
        print('=================================');
        print('User is signed in!');
        print('=================================');

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

    final prefs = await SharedPreferences.getInstance();

    final availUser = await _getUserById(userCredential.user.uid);

    print("AVAIL USER $availUser");

    if (userCredential.user.uid != null) {
      //get the user

      if (!availUser) {
        await _createUser(
            id: userCredential.user.uid,
            number: userCredential.user.phoneNumber);
      }

      print("there is a user");

      String userData = json.encode({
        'id': userCredential.user.uid,
        'number': userCredential.user.phoneNumber,
        //'token': userCredential.credential.token
      });

      //userCredential.credential.providerId
      await prefs.setString('userData', userData);

      _status = Status.Authenticated;

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomeScreen(),
      //   ),
      // );
      loggedIn = true;
      notifyListeners();
    }
  }

  Future<void> verifyPhoneNumber(BuildContext context, String number) async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
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

  Future<void> _createUser({String id, String number}) async {
    print('=================================');
    print('CREATE USER METHOD');
    print('=================================');
    Map<String, dynamic> values = {
      'id': id,
      'number': number,
    };

    await users
        .doc(id)
        .set(values)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<bool> _getUserById(String id) async {
    print('=================================');
    print('GET USER METHOD');
    print('=================================');
    try {
      await firestore
          .collection('users')
          .doc(id)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('=================================');
          print('MERONG DATA');
          print('=================================');

          _id = documentSnapshot.data()['id'];
          _number = documentSnapshot.data()['number'];
          return true;
        } else {
          print('Document does not exist on the databaseseses');
          return false;
        }
      });
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
    final prefs = await SharedPreferences.getInstance();
    prefs.clear().then((res) async {
      if (res) {
        //_auth.signOut();
        await auth.signOut();
        _status = Status.Uninitialized;

        //notifyListeners();
        _id = null;
        _number = null;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => FastAid(),
          ),
        );

        //return Future.delayed(Duration.zero);
      }
    });
  }
}

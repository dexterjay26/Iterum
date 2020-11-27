import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../helpers/user_helper.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;
  bool _hasAccount;

  UserCredential _userCredential;
  final userHelper = UserHelper();

  GoogleSignInProvider() {
    _isSigningIn = false;

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
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

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

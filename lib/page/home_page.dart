import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/logged_in_widget.dart';
import '../widgets/sign_up_widget.dart';
import '../providers/google_sign_in.dart';


//import '../screens/signup_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider = Provider.of<GoogleSignInProvider>(context);
          if (provider.isSigningIn) {
            return buildLoading();
          } else if (snapshot.hasData) {
            if (provider.userCredentials == null) {
              provider.logout();
              return SignUpWidget();
            }
            return LoggedInWidget();
          } else {
            return SignUpWidget();
            //return SignupScreen();
          }
        },
      ),
    );
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());
}

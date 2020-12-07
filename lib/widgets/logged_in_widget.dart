import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/signup_screen.dart';
import '../providers/google_sign_in.dart';

class LoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser;
    final provider = Provider.of<GoogleSignInProvider>(context);

    return provider.hasAccount ? HomeScreen() : SignupScreen();
  }
}

// alignment: Alignment.center,
//             color: Colors.blueGrey.shade900,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'Logged In',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 SizedBox(height: 8),
//                 CircleAvatar(
//                   maxRadius: 25,
//                   backgroundImage: NetworkImage(user.photoURL),
//                 ),
//                 Text(
//                   'Name: ' + user.displayName,
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Email: ' + user.email,
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     Provider.of<GoogleSignInProvider>(context, listen: false)
//                         .logout();
//                   },
//                   child: Text('Logout'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(
//                         MaterialPageRoute(builder: (ctx) => SignupScreen()));
//                   },
//                   child: Text('Test Sign up'),
//                 ),
//               ],
//             ),
//           )

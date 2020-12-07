import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/google_sign_in.dart';

class UserInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final userCredentials = provider.userCredentials;
    DocumentSnapshot userSnapShot;
    Future.delayed(Duration.zero, () async {
      userSnapShot = await provider.getUserSnapShot();
    });

    final mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: Column(
        //alignment: Alignment.center,
        //height: 230,
        children: [
          Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: [
              Container(
                width: mediaQuery.width,
                height: 180,
                child: Image.asset(
                  'assets/images/gradient.png',
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 110,
                child: ClipOval(
                  //borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  child: Container(
                    child: Image.network(
                      userCredentials.user.photoURL,
                      fit: BoxFit.cover,
                    ),
                    width: 140,
                    height: 140,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 90,
          ),
          Text(
            userCredentials.user.displayName,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 10),
          Container(
            height: 150,
            child: Image.asset(
              'assets/images/boxbox.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: 200,
            height: 50,
            child: FlatButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (_) => UserInfoEdit(userSnapShot)));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                  color: Colors.orange,
                ),
              ),
              color: Colors.orange,
              child: Text(
                'Edit Information',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 200,
            height: 50,
            child: FlatButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    content: Container(
                      width: 400,
                      child: Image.asset('assets/images/bepart.png',
                          fit: BoxFit.contain),
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () async {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Cheers!'),
                      )
                    ],
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                'Be a Volunteer!',
                style: TextStyle(color: Colors.orange, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

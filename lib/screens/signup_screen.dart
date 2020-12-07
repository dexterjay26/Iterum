import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/signup_next_screen.dart';
import '../providers/google_sign_in.dart';

class SignupScreen extends StatefulWidget {
  //final DateTime birthDate;
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //DateTime _selectedDate;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context);
    final userData = provider.userCredentials;
    final width = MediaQuery.of(context).size.width;

    nameController.text = userData.user.displayName;
    numberController.text = userData.user.phoneNumber;

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          width: width * .8,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 24, color: Colors.orange),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              // TextField(
              //   controller: emailController,
              //   decoration: InputDecoration(labelText: 'Email'),
              // ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Contact',
                  style: TextStyle(fontSize: 24, color: Colors.orange),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: numberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              // RaisedButton(
              //   onPressed: _presentDatePicker,
              //   child: Text(_selectedDate == null
              //       ? 'Selected Date'
              //       : (DateFormat.yMd().format(_selectedDate)).toString()),
              // ),
              // TextField(
              //   controller: addressController,
              //   decoration: InputDecoration(labelText: 'Address'),
              // ),
              Spacer(),
              Container(
                height: 60,
                width: 220,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                      color: Colors.orange,
                    ),
                  ),
                  color: Colors.orange,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => NextSignupScreen(
                          id: userData.user.uid,
                          name: nameController.text,
                          email: userData.user.email,
                          number: numberController.text,
                          imgUrl: userData.user.photoURL,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Spacer(),
              // RaisedButton(
              //   onPressed: () {
              //     Provider.of<GoogleSignInProvider>(context, listen: false)
              //         .skipSetup(
              //       id: userData.user.uid,
              //       email: userData.user.email,
              //       name: userData.user.displayName,
              //       number: userData.user.phoneNumber,
              //       photoUrl: userData.user.photoURL,
              //     );
              //   },
              //   child: Text('Skip'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

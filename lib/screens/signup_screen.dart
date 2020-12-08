import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/signup_next_screen.dart';
import '../providers/google_sign_in.dart';
import '../widgets/custom_button.dart';

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

    void _next() {
      Navigator.of(context).pushReplacement(
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
    }

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
              Spacer(),
              CustomButton(
                function: _next,
                text: "Next",
                height: 60,
                width: 220,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

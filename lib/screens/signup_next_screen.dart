import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './take_selfie_screen.dart';

class NextSignupScreen extends StatefulWidget {
  final id;
  final name;
  final email;
  final number;
  final imgUrl;

  NextSignupScreen({
    this.id,
    this.name,
    this.email,
    this.number,
    this.imgUrl,
  });

  //final DateTime birthDate;
  @override
  _NextSignupScreenState createState() => _NextSignupScreenState();
}

class _NextSignupScreenState extends State<NextSignupScreen> {
  DateTime _selectedDate;
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<GoogleSignInProvider>(context);
    // final userData = provider.userCredentials;
    final width = MediaQuery.of(context).size.width;

    emailController.text = widget.email;

    void _presentDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
          birthDateController.text =
              (DateFormat.yMd().format(pickedDate)).toString();
          print(_selectedDate);
        });
      });
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
                  'Email',
                  style: TextStyle(fontSize: 24, color: Colors.orange),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Birth Date',
                  style: TextStyle(fontSize: 24, color: Colors.orange),
                ),
              ),

              SizedBox(height: 5),
              GestureDetector(
                onTap: _presentDatePicker,
                child: TextField(
                  controller: birthDateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  enabled: false,
                ),
              ),
              SizedBox(height: 20),
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
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Address',
                  style: TextStyle(fontSize: 24, color: Colors.orange),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
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
                        builder: (ctx) => TakeSelfie(
                          id: widget.id,
                          name: widget.name,
                          email: widget.email,
                          number: widget.number,
                          imgUrl: widget.imgUrl,
                          birthDate: _selectedDate.toIso8601String(),
                          address: addressController.text,
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

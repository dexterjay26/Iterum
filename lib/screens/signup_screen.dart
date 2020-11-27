import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/google_sign_in.dart';
import './take_selfie_screen.dart';

class SignupScreen extends StatefulWidget {
  //final DateTime birthDate;
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  DateTime _selectedDate;

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
    emailController.text = userData.user.email;
    numberController.text = userData.user.phoneNumber;

    void _presentDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
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
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'Number'),
              ),
              RaisedButton(
                onPressed: _presentDatePicker,
                child: Text(_selectedDate == null
                    ? 'Selected Date'
                    : (DateFormat.yMd().format(_selectedDate)).toString()),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => TakeSelfie(
                        id: userData.user.uid,
                        name: nameController.text,
                        email: userData.user.email,
                        birthDate: _selectedDate.toIso8601String(),
                        number: numberController.text,
                        address: addressController.text,
                        imgUrl: userData.user.photoURL,
                      ),
                    ),
                  );
                },
                child: Text('Next'),
              ),
              RaisedButton(
                onPressed: () {
                  Provider.of<GoogleSignInProvider>(context, listen: false)
                      .skipSetup(
                    id: userData.user.uid,
                    email: userData.user.email,
                    name: userData.user.displayName,
                    number: userData.user.phoneNumber,
                    photoUrl: userData.user.photoURL,
                  );
                },
                child: Text('Skip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Form(
//             key: _form,
//             child: Column(
//               children: [
//                 TextFormField(
//                   //controller: nameController,
//                   initialValue: userData.displayName,
//                   decoration: InputDecoration(labelText: 'Name'),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return "Please enter name";
//                     } else {}
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   initialValue: userData.email,
//                   //controller: emailController,
//                   decoration: InputDecoration(labelText: 'Email'),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return "Please enter email";
//                     }
//                     return null;
//                   },
//                   enabled: false,
//                 ),
//                 TextFormField(
//                   initialValue: userData.phoneNumber,
//                   decoration: InputDecoration(labelText: 'Phone Number'),
//                   validator: (value) {
//                     if (value.length < 11) {
//                       return "Please enter correct number";
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   initialValue: _selectedDate == null
//                       ? ''
//                       : DateFormat.yMd().format(_selectedDate),
//                   decoration: InputDecoration(labelText: 'Date'),
//                 ),
//                 RaisedButton.icon(
//                   onPressed: _presentDatePicker,
//                   icon: Icon(Icons.calendar_today),
//                   label: Text('Select Date'),
//                 ),
//               ],
//             ),
//           ),

import 'package:FastAid/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen.dart';
import '../providers/google_sign_in.dart';

class TakeSelfie extends StatefulWidget {
  final id;
  final name;
  final email;
  final number;
  final birthDate;
  final address;
  final String imgUrl;

  TakeSelfie({
    this.id,
    this.name,
    this.email,
    this.number,
    this.imgUrl,
    this.birthDate,
    this.address,
  });

  @override
  _TakeSelfieState createState() => _TakeSelfieState();
}

class _TakeSelfieState extends State<TakeSelfie> {
  @override
  Widget build(BuildContext context) {
    void _signUp() {
      Provider.of<GoogleSignInProvider>(context, listen: false).createUser(
        id: widget.id,
        name: widget.name,
        email: widget.email,
        birthDate: widget.birthDate,
        address: widget.address,
        number: widget.number,
        imgUrl: widget.imgUrl,
      );
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
    }

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 150),
          child: Column(
            children: [
              CircleAvatar(
                radius: 85,
                backgroundImage: widget.imgUrl.isEmpty
                    ? null
                    : NetworkImage(
                        widget.imgUrl,
                      ),
              ),
              Spacer(),
              Spacer(),
              CustomButton(
                function: _signUp,
                text: "Take a Selfie",
                height: 60,
                width: 220,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                function: _signUp,
                text: "Select Image",
                height: 60,
                width: 220,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                function: _signUp,
                text: "Finish",
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

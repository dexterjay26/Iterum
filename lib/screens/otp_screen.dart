import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  final first = FocusNode();
  final second = FocusNode();
  final third = FocusNode();
  final fourth = FocusNode();
  final fifth = FocusNode();
  final sixth = FocusNode();

  String otpCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 20,
                child: TextField(
                  maxLength: 1,
                  onChanged: (val) {
                    otpCode += val;
                    FocusScope.of(context).requestFocus(second);
                  },
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 20,
                child: TextField(
                  maxLength: 1,
                  onChanged: (val) {
                    otpCode += val;
                    FocusScope.of(context).requestFocus(third);
                  },
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 20,
                child: TextField(
                  maxLength: 1,
                  onChanged: (val) {
                    otpCode += val;
                    FocusScope.of(context).requestFocus(fourth);
                  },
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 20,
                child: TextField(
                  maxLength: 1,
                  onChanged: (val) {
                    otpCode += val;
                    FocusScope.of(context).requestFocus(fifth);
                  },
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 20,
                child: TextField(
                  maxLength: 1,
                  onChanged: (val) {
                    otpCode += val;
                    FocusScope.of(context).requestFocus(sixth);
                  },
                ),
              ),
              SizedBox(width: 5),
            ],
          )
        ],
      )),
    );
  }

  // Widget otpTextFieldBuilder(){
  //   return Container(width: 20, child: TextF,);
  // }
}

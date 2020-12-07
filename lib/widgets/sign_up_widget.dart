import './google_signup_button_widget.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => buildSignUp();

  Widget buildSignUp() => Column(
        children: [
          Spacer(),
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 20),
              width: 300,
              height: 80,
              child: Image.asset('assets/images/LOGO_APP.png'),
            ),
          ),
          Spacer(),
          GoogleSignupButtonWidget(),
          SizedBox(
            height: 12,
          ),
          Text(
            'Login to continue',
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
        ],
      );
}

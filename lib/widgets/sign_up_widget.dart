import './google_signup_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => buildSignUp();

  //GoogleSignupButtonWidget(),

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
          // SignInButton(
          //   Buttons.Google,
          //   onPressed: () {
          //     //_showButtonPressDialog(context, 'Google');
          //   },
          // ),
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

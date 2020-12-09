import 'package:flutter/material.dart';

//import './google_signup_button_widget.dart';
import './custom_button_login.dart';

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
          Spacer(),
          Spacer(),
          CustomButtonLogin(
            height: 56,
            width: 279,
            text: 'Log In',
          ),
          //GoogleSignupButtonWidget(),
          SizedBox(
            height: 12,
          ),
          CustomButtonLogin(
            height: 56,
            width: 279,
            isLogin: false,
            text: 'Sign Up',
          ),
          // Text(
          //   'Login to continue',
          //   style: TextStyle(fontSize: 16),
          // ),
          Spacer(),
        ],
      );
}

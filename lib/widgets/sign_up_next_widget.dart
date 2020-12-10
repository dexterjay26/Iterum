import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/google_sign_in.dart';
import './custom_button_social.dart';

class SignUpNextWidget extends StatelessWidget {
  final bool isLogin;
  SignUpNextWidget(this.isLogin);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          isLogin ? loginBuilder(context) : signupBuilder(context),
          Spacer(),
        ],
      ),
    );
  }

  Widget signupBuilder(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        Container(
          width: 279,
          child: Text(
            'Sign Up',
            style: TextStyle(fontSize: 24, color: primaryColor),
          ),
        ),
        SizedBox(height: 10),
        CustomButtonSocial(
          height: 56,
          width: 279,
          text: 'Sign up with Facebook',
          isGoogle: false,
          function: () {},
        ),
        //GoogleSignupButtonWidget(),
        SizedBox(
          height: 12,
        ),
        CustomButtonSocial(
          height: 56,
          width: 279,
          isGoogle: true,
          text: 'Sign up with Google',
          function: () {},
        ),
      ],
    );
  }

  Widget loginBuilder(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        Container(
          width: 279,
          child: Text(
            'Log In',
            style: TextStyle(fontSize: 24, color: primaryColor),
          ),
        ),
        SizedBox(height: 10),
        CustomButtonSocial(
          height: 56,
          width: 279,
          text: 'Login with Facebook',
          isGoogle: false,
          function: () {},
        ),
        //GoogleSignupButtonWidget(),
        SizedBox(
          height: 12,
        ),
        CustomButtonSocial(
          height: 56,
          width: 279,
          text: 'Login with Google',
          isGoogle: true,
          function: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.login();

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

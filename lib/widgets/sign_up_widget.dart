import 'package:flutter/material.dart';

import './custom_button_login.dart';
import './sign_up_next_widget.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        startButtonBuilder(context),
        Spacer(),
      ],
    );
  }

  Widget startButtonBuilder(BuildContext context) {
    
    return Column(
      children: [
        CustomButtonLogin(
          height: 56,
          width: 279,
          text: 'Log In',
          function: () {
            print('Log In');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => SignUpNextWidget(true),
              ),
            );
          },
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
          function: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => SignUpNextWidget(false),
              ),
            );
          },
        ),
      ],
    );
  }
}

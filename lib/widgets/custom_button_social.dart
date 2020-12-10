import 'package:flutter/material.dart';

class CustomButtonSocial extends StatelessWidget {
  final Function function;
  final double height;
  final double width;
  final String text;
  final bool isLogin;
  final bool isGoogle;

  CustomButtonSocial({
    this.function,
    this.height = 60,
    this.width = 220,
    this.text,
    this.isLogin = true,
    this.isGoogle = true,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: height,
      width: width,
      child: isGoogle
          ? RaisedButton.icon(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0),
              ),
              icon: new Image.asset('assets/images/google_logo.png',
                  height: 27, width: 27),
              onPressed: function,
              label: Text(text, style: TextStyle(fontSize: 18)),
            )
          : RaisedButton.icon(
              color: Color(0xFF4867AC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0),
              ),
              icon: new Image.asset('assets/images/facebook_logo.png',
                  height: 27, width: 27),
              onPressed: function,
              label: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}

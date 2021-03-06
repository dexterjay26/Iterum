import 'package:flutter/material.dart';

class CustomButtonLogin extends StatelessWidget {
  final Function function;
  final double height;
  final double width;
  final String text;
  final bool isLogin;

  CustomButtonLogin({
    this.function,
    this.height = 60,
    this.width = 220,
    this.text,
    this.isLogin = true,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      height: height,
      width: width,
      child: isLogin
          ? RaisedButton(
              color: Color(0xFFFF9F00),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0),
                side: BorderSide(
                  color: Color(0xFFFF9F00),
                ),
              ),
              onPressed: function,
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            )
          : OutlineButton(
              borderSide: BorderSide(color: primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0),
                side: BorderSide(
                  color: primaryColor,
                ),
              ),
              onPressed: function,
              child: Text(
                text,
                style: TextStyle(color: primaryColor, fontSize: 24),
              ),
            ),
    );
  }
}

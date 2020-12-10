import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function function;
  final double height;
  final double width;
  final double fontSize;
  final String text;

  CustomButton({
    this.function,
    this.height = 60,
    this.width = 220,
    this.fontSize = 20,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      height: height,
      width: width,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
          side: BorderSide(
            color: primaryColor,
          ),
        ),
        color: primaryColor,
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/google_sign_in.dart';

class CustomButton extends StatelessWidget {
  
  Function function;
  double height = 60;
  double width = 220;
  final String text;

  CustomButton({this.function, this.height, this.width, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            color: Colors.orange,
          ),
        ),
        color: Colors.orange,
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

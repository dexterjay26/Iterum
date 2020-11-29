import 'dart:ui';

import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  final headline;
  final body;
  final imagePath;

  CarouselCard({this.imagePath, this.headline, this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(imagePath),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              headline,
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          //HEADLINE
          Text(
            body,
            style: TextStyle(fontSize: 14),
          ), //BODY
        ],
      ),
    );
  }
}

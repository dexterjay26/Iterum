import 'package:flutter/material.dart';

import '../widgets/carousel_widget.dart';

class TutorialScreen extends StatelessWidget {

  List<Container> _cards = [
    Container(
      width: 500,
      color: Colors.black,
      child: Center(
        child: Text(
          "First",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.red,
      width: 300,
      child: Center(
        child: Text(
          "Second",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.yellow,
      width: 300,
      child: Center(
        child: Text(
          "Third",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.blue,
      width: 300,
      child: Center(
        child: Text(
          "Fourth",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.pink,
      width: 300,
      child: Center(
        child: Text(
          "Fifth",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselWidget(_cards);
  }
}
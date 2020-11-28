import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('https://i.imgur.com/mijjF91.png'))),
        ),
        Container(
            child: Center(
                child: new Image.asset('assets/LOGO_iterum.png',
                    width: 180.0, height: 300.0))),
      ],
    ));
  }
}

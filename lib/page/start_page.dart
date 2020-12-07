import 'package:flutter/material.dart';
import 'dart:async';

import '../screens/splash_screen.dart';
import '../screens/tutorial_screen.dart';

class StartingPage extends StatefulWidget {
  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 150),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => TutorialScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

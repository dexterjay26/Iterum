import 'package:FastAid/page/home_page.dart';
import 'package:FastAid/screens/splash_screen.dart';
import 'package:FastAid/screens/tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class StartingPage extends StatefulWidget {
  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => TutorialScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

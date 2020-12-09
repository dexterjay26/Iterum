import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import './home_page.dart';
import '../screens/splash_screen.dart';
import '../screens/tutorial_screen.dart';

class StartingPage extends StatefulWidget {
  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  bool isShowed = false;

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(milliseconds: 1500),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              isShowed ? HomePage() : TutorialScreen(),
        ),
      ),
    );

    Future.delayed(Duration.zero, () async {
      final prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey('isShowed')) {
        isShowed = prefs.getBool('isShowed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

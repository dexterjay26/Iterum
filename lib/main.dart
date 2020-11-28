import 'package:flutter/material.dart';

import './screens/tutorial_screen.dart';

void main(List<String> args) {
  runApp(FastAid());
}

class FastAid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FastAidApp(),
    );
  }
}

class FastAidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(),
      ),
    );
  }
}

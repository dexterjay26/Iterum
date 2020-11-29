import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: mediaQuery.width,
              height: mediaQuery.height,
              child: Image.asset(
                'assets/images/First.png',
                fit: BoxFit.cover,
              ),
            ),
            Image.asset(
              'assets/images/splash_logo.png',
            ),
          ],
        ),
      ),
    );
  }
}

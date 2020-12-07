import 'package:FastAid/page/home_page.dart';
import 'package:flutter/material.dart';

import '../widgets/carousel_widget.dart';
import '../widgets/carousel_cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  bool isShowed = false;
  bool isInit = true;

  List<CarouselCard> _cards = [
    CarouselCard(
      imagePath: 'assets/images/1.png',
      headline: 'Welcome to FastAID',
      body:
          'An application that allows users to help one another in need through location-based service. It is free and anyone can participate.',
    ),
    CarouselCard(
      imagePath: 'assets/images/2.png',
      headline: 'Help Others',
      body:
          'You want to help a close friend , loved one or stranger during emergencies? Yes, you can definitel be for them in two ways: An informant or a volunteer.',
    ),
    CarouselCard(
      imagePath: 'assets/images/3.png',
      headline: 'Responsive Team',
      body:
          'Time is of the essence! Whoever qualified volunteer is nearby in the time of emergency would be notified to act as a first-aider.That’s a point for you who notified and the one who aided!',
    ),
    CarouselCard(
      imagePath: 'assets/images/4.png',
      headline: 'Be a Volunteer',
      body:
          'Join us. Participate in an accredited seminar, train and be qualified enough to act as a  first-aider. Help one another and enjoy the benefits!',
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey('isShowed')) {
        setState(() {
          isShowed = prefs.getBool('isShowed');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isShowed ? HomePage() : CarouselWidget(_cards);
  }
}

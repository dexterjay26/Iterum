import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import './user_info_screen.dart';
import '../screens/learn_home_screen.dart';
import '../screens/map_screen.dart';
import '../screens/sos_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firebaseMessaging = FirebaseMessaging();

  final tabs = [
    SOSScreen(),
    MapScreen(),
    LearnHomeScreen(),
    UserInfoScreen(),
  ];

  @override
  void initState() {
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();

    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    super.initState();
  }

  void sendTokenToServer(String token) {
    print('FCM TOKEN: $token');
    //final provider = Provider.of<GoogleSignInProvider>(context);
    //e1wrQMgTTZ6N8uJvE03_He:APA91bFO9SkTEfLH1npBEfUKb2kRrYavExY21nZsElwhmFkQlgRftVyjEH5aZP_wbvYuv-2ueXdMKQpFaT2_MSJ8CZ50YwPYY5HDCAfBL55w8pikkS642gk5jQySUGC0gBOgrG9jodZe
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.orange,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            backgroundColor: Colors.orange,
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            backgroundColor: Colors.orange,
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            backgroundColor: Colors.orange,
            label: 'User',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

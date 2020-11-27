import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tabs = [
    Center(
      child: Text('Tab 1'),
    ),
    Center(
      child: Text('Tab 2'),
    ),
    Center(
      child: Text('Tab 3'),
    ),
    Center(
      child: Text('Tab 4'),
    ),
  ];

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
            icon: Icon(Icons.camera),
            backgroundColor: Colors.orange,
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            backgroundColor: Colors.orange,
            label: 'Location',
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

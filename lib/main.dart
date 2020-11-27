import './screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import './providers/auth.dart';
import './screens/mobile_auth_screen.dart';


void main(List<String> args) {
  runApp(FastAid());
}

class FastAid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth.initialize(),
        ),
      ],
      child: MaterialApp(
        title: 'Mobile Phone Auth',
        home: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return loadingBuilder();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Mobile Phone Auth"),
            ),
            body: Consumer<Auth>(
              builder: (ctx, auth, _) {
                if (auth.status == Status.Uninitialized) {
                  return loadingBuilder();
                } else if (auth.status == Status.Authenticated) {
                  return HomeScreen();
                } else if (auth.status == Status.Unauthenticated) {
                  return MobileAuthScreen();
                } else if (auth.status == Status.Authenticating) {
                  return loadingBuilder();
                } else {
                  return Center(
                    child: Text("Something went worng"),
                  );
                }
              },
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return loadingBuilder();
      },
    );
  }

  Widget loadingBuilder() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

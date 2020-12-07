import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'providers/google_sign_in.dart';
import './page/start_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => GoogleSignInProvider(),
        ),
      ],
      child: FastAid(),
    ),
  );
}

class FastAid extends StatelessWidget {
  static final String title = 'Fast Aid';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: FastAid.title,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: StartingPage(),
      );
}

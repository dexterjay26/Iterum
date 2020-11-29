import 'package:FastAid/page/start_page.dart';
import 'package:FastAid/screens/tutorial_screen.dart';
import 'package:flutter/material.dart';
import './page/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/google_sign_in.dart';
import 'package:provider/provider.dart';
import './screens/splash_screen.dart';
import './widgets/carousel_cards.dart';

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

class FastAid extends StatefulWidget {
  static final String title = 'Google SignIn';

  @override
  _FastAidState createState() => _FastAidState();
}

class _FastAidState extends State<FastAid> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: FastAid.title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: StartingPage(),
        //HomePage(),
      );
}

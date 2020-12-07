import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen.dart';
import '../providers/google_sign_in.dart';

class TakeSelfie extends StatefulWidget {
  final id;
  final name;
  final email;
  final number;
  final birthDate;
  final address;
  final String imgUrl;

  TakeSelfie({
    this.id,
    this.name,
    this.email,
    this.number,
    this.imgUrl,
    this.birthDate,
    this.address,
  });

  @override
  _TakeSelfieState createState() => _TakeSelfieState();
}

class _TakeSelfieState extends State<TakeSelfie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          child: Column(
            children: [
              Text(
                'Take a selfie',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ClipOval(
                child: Container(
                  height: 150,
                  width: 150,
                  //margin: EdgeInsets.only(top: 8, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: widget.imgUrl.isEmpty
                      ? Text("Enter a URL")
                      : FittedBox(
                          child: Image.network(
                            widget.imgUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              Spacer(),
              Container(
                height: 60,
                width: 220,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                      color: Colors.orange,
                    ),
                  ),
                  color: Colors.orange,
                  onPressed: () {
                    Provider.of<GoogleSignInProvider>(context, listen: false)
                        .createUser(
                      id: widget.id,
                      name: widget.name,
                      email: widget.email,
                      birthDate: widget.birthDate,
                      address: widget.address,
                      number: widget.number,
                      imgUrl: widget.imgUrl,
                    );
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => HomeScreen()));
                  },
                  child: Text(
                    'Finish',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

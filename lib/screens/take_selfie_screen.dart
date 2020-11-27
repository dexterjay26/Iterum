import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/google_sign_in.dart';

class TakeSelfie extends StatelessWidget {
  final id;
  final name;
  final email;
  final number;
  final birthDate;
  final address;
  String imgUrl;

  TakeSelfie({
    this.id,
    this.name,
    this.email,
    this.number,
    this.birthDate,
    this.address,
    this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          child: Column(
            children: [
              Text('Take a selfie'),
              SizedBox(height: 10),
              Container(
                height: 150,
                width: 150,
                margin: EdgeInsets.only(top: 8, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: imgUrl.isEmpty
                    ? Text("Enter a URL")
                    : FittedBox(
                        child: Image.network(
                          imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              SizedBox(height: 10),
              RaisedButton(
                onPressed: () {
                  Provider.of<GoogleSignInProvider>(context, listen: false)
                      .createUser(
                    id: id,
                    name: name,
                    email: email,
                    birthDate: birthDate,
                    address: address,
                    number: number,
                    imgUrl: imgUrl,
                  );
                },
                child: Text('Finish'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

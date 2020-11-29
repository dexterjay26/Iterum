import 'dart:convert';

import 'package:FastAid/providers/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';
import '../api/messaging.dart';

import 'package:provider/provider.dart';

class SOSScreen extends StatefulWidget {
  @override
  _SOSScreenState createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context);
    provider.isResponding(context);
    return Align(
      alignment: Alignment.center,
      child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: InkWell(
                onTap: () async {
                  setState(
                    () {
                      loading = true;
                    },
                  );
                  final locData = await Location().getLocation();
                  print(locData.latitude);
                  print(locData.longitude);

                  await Provider.of<GoogleSignInProvider>(context,
                          listen: false)
                      .sendHelp(
                    lat: locData.latitude,
                    lng: locData.longitude,
                  )
                      .then(
                    (value) {
                      print('HELP WAS SENT');
                      setState(
                        () {
                          loading = false;
                        },
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/sos_1.png'),
                ),
              ),
            ),
    );
  }
}

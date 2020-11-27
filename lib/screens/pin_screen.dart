import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  bool isConfirm = false;

  final pinController = TextEditingController();
  final confirmPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isConfirm ? confirmPinBuilder(context) : enterPinBuilder(),
    );
  }

  Widget enterPinBuilder() {
    return Center(
      child: Container(
        width: 300,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Create PIN'),
              controller: pinController,
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                setState(() {
                  isConfirm = true;
                });
              },
              child: Text("Next"),
            )
          ],
        ),
      ),
    );
  }

  Widget confirmPinBuilder(BuildContext context) {
    final provider = Provider.of<Auth>(context, listen: false);
    return Center(
      child: Container(
        width: 300,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Confirm PIN'),
              controller: confirmPinController,
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                if (pinController.text == confirmPinController.text) {
                  print("Pin Matched");
                  provider.setPin(confirmPinController.text);
                }
              },
              child: Text("Finish"),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  pinController.text = '';
                  confirmPinController.text = '';
                  isConfirm = false;
                });
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}

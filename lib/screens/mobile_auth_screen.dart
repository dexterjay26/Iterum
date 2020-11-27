import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class MobileAuthScreen extends StatelessWidget {
  final numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>(context, listen: false);
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Spacer(),
          TextField(
            controller: numberController,
            decoration: InputDecoration(
              labelText: 'Mobile Number',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          RaisedButton(
            onPressed: () async {
              await provider.verifyPhoneNumber(context, numberController.text);
            },
            child: Text("Verify"),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>(context);
    return Center(
      child: Column(
        children: [
          Text(provider.number),
          RaisedButton(onPressed: (){
            provider.signOut(context);
          })
        ],
      ),
    );
  }
}

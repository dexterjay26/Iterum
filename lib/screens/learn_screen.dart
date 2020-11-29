import 'package:flutter/material.dart';

class LearningScreen extends StatelessWidget {
  final imgPath;
  final imgHeaderPath;

  LearningScreen({
    this.imgPath,
    this.imgHeaderPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning First Aid'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * .05,
            right: MediaQuery.of(context).size.width * .05,
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              Image.asset(imgHeaderPath, fit: BoxFit.contain),
              Image.asset(imgPath, fit: BoxFit.contain),
            ],
          ),
        ),
      ),
    );
  }
}

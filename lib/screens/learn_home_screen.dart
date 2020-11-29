import 'package:FastAid/screens/learn_screen.dart';
import 'package:flutter/material.dart';

class LearnHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scrnWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Learn First-Aid'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => LearningScreen(
                      imgPath: 'assets/images/ht_text.png',
                      imgHeaderPath: 'assets/images/Heart_Attack_Info.png',
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.all(5),
                height: 150,
                width: scrnWidth * .9,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset(
                    'assets/images/heart_attack.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => LearningScreen(
                      imgPath: 'assets/images/fp_text.png',
                      imgHeaderPath: 'assets/images/Food_Poisoning_Info.png',
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.all(5),
                height: 150,
                width: scrnWidth * .9,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset(
                    'assets/images/food_poison.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(5),
                height: 150,
                width: scrnWidth * .9,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset(
                    'assets/images/injuries.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

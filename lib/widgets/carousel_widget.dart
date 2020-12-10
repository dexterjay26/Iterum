import 'package:FastAid/page/home_page.dart';
import 'package:flutter/material.dart';

import './carousel_cards.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CarouselWidget extends StatefulWidget {
  List<CarouselCard> _cards = [];
  CarouselWidget(this._cards);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    //CarouselController buttonCarouselController = CarouselController();
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: Stack(
        //fit: StackFit.expand,
        children: [
          CarouselSlider(
            //carouselController: buttonCarouselController,
            options: CarouselOptions(
              initialPage: 0,
              height: h,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
            items: widget._cards.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: w * .9,
                    child: i,
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            bottom: 150,
            right: 1,
            left: 1,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 35),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < widget._cards.length; i++)
                    if (i == _currentPage)
                      buildSlideDot(true, primaryColor)
                    else
                      buildSlideDot(false, primaryColor)
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            right: 1,
            left: 1,
            child: Column(
              children: [
                Container(
                  height: 56,
                  width: 279,
                  child: OutlineButton(
                    borderSide: BorderSide(color: Color(0xFFFF9F00)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                      side: BorderSide(
                        color: Color(0xFFFF9F00),
                      ),
                    ),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isShowed', true);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx) => HomePage()));
                    },
                    child: Text(
                      _currentPage == 3 ? "Finish" : "Skip",
                      style: TextStyle(color: Color(0xFFFF9F00), fontSize: 26),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSlideDot(bool isActive, Color primaryColor) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: isActive ? 15 : 10,
      width: isActive ? 15 : 10,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Color(0xFFFFC928),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

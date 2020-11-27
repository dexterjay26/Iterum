import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

class CarouselWidget extends StatefulWidget {
  List<Container> _cards = [];
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
                    width: w,
                    child: i,
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            bottom: 25,
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
                      buildSlideDot(true)
                    else
                      buildSlideDot(false)
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(bottom: 10),
            //   child: RaisedButton(
            //     onPressed: () {},
            //     child: Text("Skip"),
            //   ),
            // ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 10),
            child: FlatButton(
              onPressed: () {},
              child: Text(
                "Skip",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSlideDot(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

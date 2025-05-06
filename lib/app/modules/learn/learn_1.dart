import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Learn1 extends StatelessWidget {
  final List<String> imgList = [
    'assets/images/learn/call doctor.png',
    'assets/images/learn/call son.png',
    'assets/images/learn/eating.png',
    'assets/images/learn/i am not okay.png',
  ];

  Learn1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Slide untuk melihat kedipan')),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items:
                imgList
                    .map(
                      (item) => Container(
                        child: Center(
                          child: Image.asset(
                            item,
                            fit: BoxFit.contain,
                            height: height,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          );
        },
      ),
    );
  }
}

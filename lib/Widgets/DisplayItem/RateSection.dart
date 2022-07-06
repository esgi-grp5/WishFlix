import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

double? width;
double? height;

class RateSection extends StatelessWidget {
  RateSection({
    Key? key,
    final this.starNumber = 0.0,
  }) : super(key: key);

  final double starNumber;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

    return Row(
      children: [
        Container(
            color: Colors.white,
            padding: EdgeInsets.all(0),
            width: width,
            height: height! * .12 < 110 ? height! * .12 : 110,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Note :",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    RatingBarIndicator(
                      rating: starNumber,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 50.0,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ]),
            )),
      ],
    );
  }
}

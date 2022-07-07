import 'package:flutter/material.dart';
import 'package:wishflix/Screens/main.dart';

double? width;
double? height;

class RowTimesWishlisted extends StatelessWidget {
  RowTimesWishlisted({
    Key? key,
    final this.informationTitle = "Title",
    final this.informationTimesAdded = 200,
  }) : super(key: key);

  final String informationTitle;
  final int informationTimesAdded;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

    return Row(
      children: [
        Container(
            color: appTheme.backgroundColor,
            padding: EdgeInsets.all(0),
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 40,
                      color: Colors.black,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          this.informationTimesAdded.toString() +
                              " personnes ont ajouté " +
                              this.informationTitle +
                              " à leur wishlist",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            )),
      ],
    );
  }
}

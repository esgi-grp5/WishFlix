import 'package:flutter/material.dart';
import 'package:wishflix/core/di/HexColor.dart';

double? width;
double? height;

class RowInformationsWithTitle extends StatelessWidget {
  RowInformationsWithTitle({
    Key? key,
    final this.informationTitle = "",
    final this.informationContent = "",
  }) : super(key: key);

  final String informationTitle, informationContent;

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
            height: height! * .2 < 190 ? height! * .2 : 190,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      this.informationTitle,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical, //.horizontal
                    child: Text(
                      this.informationContent,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: HexColor("#555555")),
                    ),
                  ),
                ),
              ]),
            )),
      ],
    );
  }
}

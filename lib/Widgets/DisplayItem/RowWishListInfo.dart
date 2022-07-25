import 'package:flutter/material.dart';

double? width;
double? height;

class RowWishListInfo extends StatelessWidget {
  RowWishListInfo({
    Key? key,
    final this.dateSortie = "",
    final this.estVuText = "",
  }) : super(key: key);

  final String dateSortie, estVuText;

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
            height: height! * .07 < 60 ? height! * .07 : 60,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child:
                              Icon(Icons.calendar_month, color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 14),
                          child: Text(
                            this.dateSortie,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Icon(Icons.remove_red_eye_outlined,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 14),
                          child: Text(
                            this.estVuText,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

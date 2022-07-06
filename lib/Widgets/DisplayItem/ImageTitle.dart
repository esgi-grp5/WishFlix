import 'package:flutter/material.dart';

double? width;
double? height;

class ImageTitle extends StatelessWidget {
  ImageTitle({
    Key? key,
    final this.title = "",
    final this.subTitle1 = "",
    final this.subTitle2 = "",
    final this.imageAssetUrl = "",
  }) : super(key: key);

  final String title, subTitle1, subTitle2, imageAssetUrl;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

    return Row(children: <Widget>[
      Container(
        width: width,
        height: height! * .24 < 220 ? height! * .24 : 220,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(this.imageAssetUrl),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        )),
        child: Stack(
          children: <Widget>[
            Positioned(
              height: 120,
              width: width,
              left: 0,
              //right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(1),
                  Colors.black.withOpacity(0.00)
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
              ),
            ),
            Positioned(
              bottom: 45,
              left: 10,
              child: Text(
                this.title,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 25,
              left: 14,
              child: Text(
                this.subTitle1 + " • " + this.subTitle2,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            )
          ],
        ),
      )
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:wishflix/core/di/HexColor.dart';

double? width;
double? height;

class Choice08 extends StatefulWidget {
  final IconData? icon;
  final String? text;
  final bool? selected;
  Choice08({this.icon, this.text, this.selected});
  @override
  _Choice08State createState() => _Choice08State();
}

class _Choice08State extends State<Choice08>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

    return Container(
      width: 120,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: widget.selected!
          ? BoxDecoration(
              color: Colors.white.withOpacity(.30),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20,
            color: HexColor("ff9900"),
          ),
          SizedBox(
            width: width! * .020,
          ),
          Text(
            widget.text!,
            textAlign: TextAlign.left,
            style: TextStyle(color: HexColor("ff9900"), fontSize: 16),
          )
        ],
      ),
    );
  }
}

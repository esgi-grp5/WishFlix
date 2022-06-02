import 'package:flutter/material.dart';
import 'package:wishflix/Screens/main.dart' as mainPage;

double? width;
double? height;

class TrendingSection extends StatefulWidget {
  final String? name;
  final List<dynamic>? list;

  TrendingSection({required this.name, required this.list});
  @override
  _TrendingSectionState createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<TrendingSection>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // SizedBox(
              //   width: width! * 0.05,
              // ),
              Text(
                widget.name!,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Spacer(),
              Text("AFFICHER PLUS",
                  style: TextStyle(
                      fontSize: 14, color: mainPage.appTheme.primaryColor))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            height: height! * .25 < 170 ? height! * .25 : 170,
            //height: height! * .25 < 300 ? height! * .25 : 300,
            // child:
            // ConstrainedBox(
            //   constraints: BoxConstraints(maxHeight: 170, minHeight: height! * .13),
            child: ListView.builder(
                itemBuilder: (context, index) => widget.list![index],
                shrinkWrap: true,
                padding: EdgeInsets.all(0.0),
                itemCount: widget.list!.length,
                scrollDirection: Axis.horizontal),
          ),
        ),
      ],
    );
  }
}

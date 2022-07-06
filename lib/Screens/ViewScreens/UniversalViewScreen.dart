import 'package:flutter/material.dart';
import 'package:wishflix/Screens/main.dart' as rootPage;

double? width;
double? height;

class UniversalViewScreen extends StatelessWidget {
  final List<Widget> screenBody;

  UniversalViewScreen({required this.screenBody});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    debugPrint('--------- height : ' + height.toString());
    debugPrint('--------- width : ' + width.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: rootPage.appTheme.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'MOVIE',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: screenBody),
      ),
    );
  }
}

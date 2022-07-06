import 'package:flutter/material.dart';
import 'package:wishflix/Screens/main.dart' as rootPage;

double? width;
double? height;

class UniversalViewScreen extends StatelessWidget {
  final List<Widget> screenBody;
  final String screenTitle;

  UniversalViewScreen({required this.screenBody, required this.screenTitle});

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
          screenTitle.toUpperCase(),
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

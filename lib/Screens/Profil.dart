import 'package:flutter/material.dart';
import 'package:wishflix/Widgets/Clipper08.dart';
import 'package:wishflix/Classes/HexColor.dart';
import 'package:wishflix/Screens/main.dart' as rootPage;
import 'Notifications.dart' as notificationPage;

double? width;
double? height;

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ProfilTop(),
            ProfilBot(),
          ],
        ),
      ),
    );
  }
}

class ProfilTop extends StatefulWidget {
  @override
  _ProfilTop createState() => _ProfilTop();
}

class _ProfilTop extends State<ProfilTop> {
  TextEditingController c = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          //semi red clippath with more height and with 0.5 opacity
          opacity: 1,
          child: ClipPath(
            clipper: Clipper08(), //set our custom wave clipper
            child: Container(
              // color: HexColor("000000"),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    rootPage.appTheme.primaryColor,
                    rootPage.appTheme.scaffoldBackgroundColor
                  ])),
              // height: height! * .65 < 460 ? height! * .65 : 510, //400
              height: (height! * .6) + 10, //400
            ),
          ),
        ),
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            color: rootPage.appTheme.primaryColor,
            height: height! * .6, //400
            // height: height! * .65 < 450 ? height! * .65 : 500, //400
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height! / 16,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png',
                        height: 50,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height! / 16,
                ),
                // Text(
                //   'Profil',
                //   style: TextStyle(
                //     fontSize: 24.0,
                //     color: HexColor("ff9900"),
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  //image profile
                ),
                SizedBox(
                  height: 13,
                ),
                Text(
                  'Pseudo',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: HexColor("ff9900"),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Positioned(
            right: 20,
            top: 65,
            child: Container(
              child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              notificationPage.Notification()),
                    );
                  }),
            )),
      ],
    );
  }
}

class ProfilBot extends StatefulWidget {
  @override
  _ProfilBot createState() => _ProfilBot();
}

class _ProfilBot extends State<ProfilBot> {
  TextEditingController c = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.center, children: const <Widget>[
        Icon(Icons.email),
        Text(
          'Email',
          style: TextStyle(fontSize: 20),
        ),
      ]),
      SizedBox(
        height: 20,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: const <Widget>[
        Icon(Icons.phone),
        Text(
          'Téléphone',
          style: TextStyle(fontSize: 20),
        ),
      ]),
    ]);
  }
}

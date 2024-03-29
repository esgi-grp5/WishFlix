import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wishflix/Widgets/General/Clipper08.dart';
import 'package:wishflix/core/di/HexColor.dart';
import 'package:wishflix/Screens/main.dart' as rootPage;
import 'package:wishflix/Widgets/General/CustomBottomNavBar.dart';
import 'package:wishflix/core/di/app_routes.dart';
import 'package:wishflix/models/user_model.dart';
// import 'NotificationsScreen.dart' as notificationPage;

double? width;
double? height;
final User user = User();

String id = "";
String username = "";
String mail = "";

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

    id = user.getId().toString();
    username = user.getUsername();
    mail = user.getMail();

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(2),
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
                  username,
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
                    Navigator.pushNamed(context, kNotifRoute);
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
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Icon(Icons.email),
        Text(
          mail,
          style: TextStyle(fontSize: 20),
        ),
      ]),
      SizedBox(
        height: 20,
      ),
      ElevatedButton.icon(
          onPressed: (){
            disconnectUser();
          }, 
          icon: Icon(Icons.logout ),
          label: Text("Se déconnecter"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(rootPage.appTheme.primaryColor),
            padding: MaterialStateProperty.all(EdgeInsets.all(10)),
      ),
      ),
    ]);
  }
}

disconnectUser(){
    final User user = User();
    user.disconnectUser();
    SystemNavigator.pop();
}
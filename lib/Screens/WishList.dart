import 'package:flutter/material.dart';
import 'package:wishflix/Screens/Notifications.dart' as prefix0;
import 'package:wishflix/Screens/main.dart' as mainPage;

// Classes
import 'package:wishflix/Classes/HexColor.dart';
import 'package:wishflix/Classes/Book.dart';
import 'package:wishflix/Classes/Game.dart';
import 'package:wishflix/Classes/Movie.dart';
import 'package:wishflix/Classes/Serie.dart';
// Widgets
import 'package:wishflix/Widgets/TrendingSection.dart';
import 'package:wishflix/Widgets/Choice08.dart';
import 'package:wishflix/Widgets/Clipper08.dart';

double? width;
double? height;

class WishList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            WishListTop(),
            myMovieList,
            mySerieList,
            myBookList,
            myGameList
          ],
        ),
      ),
    );
  }
}

var selectedType = 4;

class WishListTop extends StatefulWidget {
  @override
  _WishListTop createState() => _WishListTop();
}

class _WishListTop extends State<WishListTop> {
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
                    mainPage.appTheme.primaryColor,
                    mainPage.appTheme.scaffoldBackgroundColor
                  ])),
              // height: height! * .65 < 460 ? height! * .65 : 510, //400
              height: (height! * .6) + 10,
            ),
          ),
        ),
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            color: mainPage.appTheme.primaryColor,
            height: height! * .6, //400
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
                Text(
                  'Ma liste',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: HexColor("ff9900"),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height! * 0.0375),
                SizedBox(
                  height: height! * 0.025,
                ),
                // myMovieList,
                // myGameList
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Choice08(
                          icon: Icons.filter_alt_off,
                          text: "TOUS",
                          selected: selectedType == 4),
                      onTap: () {
                        setState(() {
                          selectedType = 4;
                        });
                      },
                    ),
                    SizedBox(
                      width: width! * 0.055,
                    ),
                  ],
                ),
                SizedBox(
                  height: height! * .015,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: Choice08(
                          icon: Icons.movie_outlined,
                          text: "Films",
                          selected: selectedType == 0),
                      onTap: () {
                        setState(() {
                          selectedType = 0;
                        });
                      },
                    ),
                    SizedBox(
                      width: width! * 0.055,
                    ),
                    InkWell(
                      child: Choice08(
                          icon: Icons.theaters,
                          text: "Séries",
                          selected: selectedType == 1),
                      onTap: () {
                        setState(() {
                          selectedType = 1;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: height! * 0.015,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: Choice08(
                          icon: Icons.book,
                          text: "Livres",
                          selected: selectedType == 2),
                      onTap: () {
                        setState(() {
                          selectedType = 2;
                        });
                      },
                    ),
                    SizedBox(
                      width: width! * 0.055,
                    ),
                    InkWell(
                      child: Choice08(
                          icon: Icons.gamepad,
                          text: "Jeux",
                          selected: selectedType == 3),
                      onTap: () {
                        setState(() {
                          selectedType = 3;
                        });
                      },
                    )
                  ],
                )
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
                          builder: (context) => prefix0.Notification()),
                    );
                  }),
            )),
      ],
    );
  }
}

var myMovieList =
    TrendingSection(name: "Films du moment", list: Movie.getDemo());
var mySerieList = TrendingSection(name: "Jeux du moment", list: Game.getDemo());
var myBookList =
    TrendingSection(name: "Series du moment", list: Serie.getDemo());
var myGameList =
    TrendingSection(name: "Livres du moment", list: Book.getDemo());

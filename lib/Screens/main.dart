import 'package:flutter/material.dart';
// Pages
import 'package:wishflix/Screens/WishList.dart';
import 'package:wishflix/Screens/SearchPage.dart';
import 'package:wishflix/Screens/Profil.dart';
import 'package:wishflix/Screens/SplashScreen.dart';
import 'package:wishflix/Screens/Notifications.dart' as prefix0;
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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: LoginScreen(),
    home: SplashScreen(),
    theme: appTheme,
    title: "WishList",
  ));
}

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("FFA31A"),
  primaryColor: HexColor("1B1B1B"),
  /* Colors.tealAccent,*/
  secondaryHeaderColor: HexColor("1B1B1B"),
  /* Colors.teal*/
  fontFamily: 'Gotham',
);

int sel = 0;
double? width;
double? height;
final bodies = [HomeScreen(), WishList(), Profil(), prefix0.Notification()];

class RootScreen extends StatefulWidget {
  RootScreen({Key? key}) : super(key: key);

  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  List<BottomNavigationBarItem> createItems() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        backgroundColor: appTheme.primaryColor,
        activeIcon: Icon(
          Icons.home,
          color: appTheme.scaffoldBackgroundColor,
        ),
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        label: "Accueil"));
    items.add(BottomNavigationBarItem(
        backgroundColor: appTheme.primaryColor,
        activeIcon: Icon(
          Icons.favorite,
          color: appTheme.scaffoldBackgroundColor,
        ),
        icon: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        label: "WishList"));
    items.add(BottomNavigationBarItem(
        backgroundColor: appTheme.primaryColor,
        activeIcon: Icon(
          Icons.person,
          color: appTheme.scaffoldBackgroundColor,
        ),
        icon: Icon(
          Icons.person,
          color: Colors.white,
        ),
        label: "Profil"));
    // items.add(
    //   BottomNavigationBarItem(
    //       backgroundColor: appTheme.primaryColor,
    //       activeIcon: Icon(
    //         Icons.notifications,
    //         color: appTheme.scaffoldBackgroundColor,
    //       ),
    //       icon: Icon(
    //         Icons.notifications,
    //         color: Colors.white,
    //       ),
    //       label: "Notifications"),
    // );
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bodies.elementAt(sel),
        bottomNavigationBar: BottomNavigationBar(
          items: createItems(),
          unselectedItemColor: Colors.white,
          selectedItemColor: appTheme.scaffoldBackgroundColor,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: sel,
          elevation: 1.5,
          onTap: (int index) {
            if (index != sel)
              setState(() {
                sel = index;
              });
          },
        ));
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigation.selindex=0;

    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            HomeTop(),
            trendingMovies,
            trendingSeries,
            trendingBooks,
            trendingGames,
          ],
        ),
      ),
    );
  }
}

var selectedType = 0;
List<String> contentType = ['Films', 'Séries', 'Livres', 'Jeux', 'Tous'];

class HomeTop extends StatefulWidget {
  @override
  _HomeTop createState() => _HomeTop();
}

class _HomeTop extends State<HomeTop> {
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
                      colors: [HexColor("1B1B1B"), HexColor("FFA31A")])),
              // height: height! * .65 < 460 ? height! * .65 : 510, //400
              height: (height! * .6) + 10, //400
            ),
          ),
        ),
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            color: HexColor("1B1B1B"),
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
                Text(
                  'Que recherchez-vous ?',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: HexColor("ff9900"),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height! * 0.0375),
                Container(
                  width: 335,
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      controller: c,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 13),
                          suffixIcon: Material(
                            child: InkWell(
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SearchPage(
                                      contentTypeTemp:
                                          contentType[selectedType],
                                      contentTypeIdTemp: selectedType,
                                      searchTextTemp: c.text);
                                }));
                              },
                            ),
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: height! * 0.03,
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

// Widgets trending

var trendingMovies =
    TrendingSection(name: "Films du moment", list: Movie.getDemo());
var trendingGames =
    TrendingSection(name: "Jeux du moment", list: Game.getDemo());
var trendingSeries =
    TrendingSection(name: "Series du moment", list: Serie.getDemo());
var trendingBooks =
    TrendingSection(name: "Livres du moment", list: Book.getDemo());

import 'package:flutter/material.dart';
// Pages
import 'package:wishflix/Screens/WishList.dart';
import 'package:wishflix/Screens/Profil.dart';
import 'package:wishflix/Screens/SplashScreen.dart';
import 'package:wishflix/Screens/HomeScreen.dart';
import 'package:wishflix/Screens/Notifications.dart' as notifPage;
// Classes
import 'package:wishflix/Classes/HexColor.dart';

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
  backgroundColor: HexColor("FFA31A"),
  primaryColor: HexColor("000000"),
  /* Colors.tealAccent,*/
  secondaryHeaderColor: HexColor("000000"),
  /* Colors.teal*/
  fontFamily: 'Gotham',
);

int sel = 0;
double? width;
double? height;
final bodies = [HomeScreen(), WishList(), Profil(), notifPage.Notification()];
int selectedType = 0;
List<String> contentType = ['Films', 'Séries', 'Livres', 'Jeux', 'Tous'];

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
    return items;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

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

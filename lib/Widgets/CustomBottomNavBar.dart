import 'package:flutter/material.dart';
import 'package:wishflix/Screens/HomeScreen.dart' as homePage;
import 'package:wishflix/Screens/main.dart' as rootPage;
import 'package:wishflix/app_routes.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int index;
  CustomBottomNavBar(this.index);
  // flutter init function
  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: createItems(),
      unselectedItemColor: Colors.white,
      selectedItemColor: rootPage.appTheme.scaffoldBackgroundColor,
      type: BottomNavigationBarType.shifting,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      currentIndex: index,
      elevation: 1.5,
      onTap: (int indexCible) {
        // setState(() {
        //   sel = indexCible;
        // });
        switch (indexCible) {
          case 0:
            Navigator.pushReplacementNamed(context, kHomeRoute);
            break;
          case 1:
            Navigator.pushReplacementNamed(context, kWishRoute);
            break;
          case 2:
            Navigator.pushReplacementNamed(context, kProfilRoute);
            break;
        }
      },
    );
  }
}

createItems() {
  List<BottomNavigationBarItem> items = [];
  items.add(BottomNavigationBarItem(
      backgroundColor: rootPage.appTheme.primaryColor,
      activeIcon: Icon(
        Icons.home,
        color: rootPage.appTheme.scaffoldBackgroundColor,
      ),
      icon: Icon(
        Icons.home,
        color: Colors.white,
      ),
      label: "Accueil"));
  items.add(BottomNavigationBarItem(
      backgroundColor: rootPage.appTheme.primaryColor,
      activeIcon: Icon(
        Icons.favorite,
        color: rootPage.appTheme.scaffoldBackgroundColor,
      ),
      icon: Icon(
        Icons.favorite,
        color: Colors.white,
      ),
      label: "WishList"));
  items.add(BottomNavigationBarItem(
      backgroundColor: rootPage.appTheme.primaryColor,
      activeIcon: Icon(
        Icons.person,
        color: rootPage.appTheme.scaffoldBackgroundColor,
      ),
      icon: Icon(
        Icons.person,
        color: Colors.white,
      ),
      label: "Profil"));
  return items;
}

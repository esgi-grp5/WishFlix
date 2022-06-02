import 'package:flutter/material.dart';
import 'package:wishflix/Screens/Login.dart';
import 'package:wishflix/Screens/main.dart' as mainPage;

// import 'package:wishflix/Screens/main.dart';

// Todo token en cache pour verif si connecté
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  TextEditingController c = TextEditingController(text: "");

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      // Vefif si connecté
      bool isLogin = false;
      if (!isLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } /*else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RootScreen()),
        );
      };*/
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainPage.appTheme.primaryColor,
        // Ajouter logo
        body: Center(
          child: Image.asset(
            'assets/images/logo_mini.png',
            height: 150,
          ),
        ));
  }
}

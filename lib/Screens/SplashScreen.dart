// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:wishflix/Screens/Login.dart';
import 'package:wishflix/Screens/main.dart' as rootPage;
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

// import 'package:wishflix/Screens/main.dart';

// Todo token en cache pour verif si connecté
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

var nextScreen;

class _SplashScreen extends State<SplashScreen> {
  TextEditingController c = TextEditingController(text: "");

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      // Vefif si connecté
      bool isLogin = false;
      if (!isLogin) {
        nextScreen = LoginScreen();
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );
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
    // final assetsAudioPlayer = AssetsAudioPlayer();
    // assetsAudioPlayer.open(
    //     Audio("assets/sounds/introsound.mp3"),
    // );
    // assetsAudioPlayer.play();
    return MaterialApp(
        title: 'WishFlix',
        home: AnimatedSplashScreen.withScreenFunction(
            duration: 1000,
            splash: 'assets/images/logo_mini.png',
            splashIconSize: 125,
            centered: true,
            screenFunction: () async {
              bool isLogin = false;
              if (!isLogin) {
                return LoginScreen();
              } /*else{
                 return rootPage.RootScreen();
              }*/
            },
            // nextScreen: LoginScreen(),
            splashTransition: SplashTransition.sizeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: rootPage.appTheme.primaryColor));
  }
}

// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:wishflix/Screens/LoginScreen.dart';
import 'package:wishflix/Screens/main.dart' as rootPage;

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wishflix/models/user_model.dart';

// import 'package:wishflix/Screens/main.dart';

// Todo token en cache pour verif si connecté
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}


var nextScreen;

  void asyncInitState() async{
    debugPrint('lgn --------- asyncInitState');
    final User user = User();

    await user.importFromStorage();
    
    debugPrint('lgn --------- loginSaved : ${user.username}');

    if(user.id > 0){
      bool successfullogin = await user.authUserApi();
      debugPrint('lgn --------- successfullogin : $successfullogin');

      if(successfullogin == true){
        user.setIsConnected();
      }else{
        user.disconnectUser();
      }
    }else
    {
      user.disconnectUser();
    }
}

class _SplashScreen extends State<SplashScreen> {
  TextEditingController c = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('lgn --------- SPLASH SCREEN isLogin : ');

    // final assetsAudioPlayer = AssetsAudioPlayer();
    // assetsAudioPlayer.open(
    //     Audio("assets/sounds/introsound.mp3"),
    // );
    // assetsAudioPlayer.play();
    return Scaffold(
        body: AnimatedSplashScreen(
            duration: 1000,
            splash: 'assets/images/logo_mini.png',
            splashIconSize: 125,
            centered: true,
            nextScreen: LoginScreen(),

            // screenFunction: () async {
            //   Navigator.pushReplacementNamed(context, kLoginRoute);
            //   /*bool isLogin = false;
            //   if (!isLogin) {
            //     return LoginScreen();
            //   }else{
            //      return rootPage.RootScreen();
            //   }*/
            // },
            // nextScreen: LoginScreen(),
            splashTransition: SplashTransition.sizeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: rootPage.appTheme.primaryColor));
  }
}

class UserData {
  UserData(
      {
      required this.id,
      required this.username,
      required this.mail,
      required this.md5Pw});

  int id;
  String username, mail, md5Pw;
}


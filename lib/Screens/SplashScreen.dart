// import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wishflix/Screens/LoginScreen.dart';
import 'package:wishflix/Screens/main.dart' as rootPage;
import 'package:http/http.dart' as http;

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishflix/Widgets/General/OAuth.dart';
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

    UserData userData = await isLoginSaved();
    debugPrint('lgn --------- loginSaved : ${userData.username}');

    if(userData.id > 0){
      bool successfullogin = await authUserApi(userData);
      debugPrint('lgn --------- successfullogin : $successfullogin');

      if(successfullogin == true){
        user.setIsConnected();
      }else{
        user.setIsDisconnected();
      }
    }else
    {
      user.setIsDisconnected();
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
Future<dynamic> isLoginSaved() async{
    final prefs = await SharedPreferences.getInstance();

    final userid = prefs.getInt('id') ?? 0;
    debugPrint("userId = $userid");
    UserData userData = new UserData(id: prefs.getInt('id') ?? 0, username: prefs.getString('username') ?? "", mail: prefs.getString('mail') ?? "", md5Pw: prefs.getString('md5Pw') ?? "");


    if(userData.id > 0){
      return userData;
    }else{
      return null;
    }
  }

  void saveSession(_user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _user.username);
    prefs.setString('mail', _user.mail);
    prefs.setString('md5Pw', _user.md5Pw);
    prefs.setInt('id', _user.id);
  }

  Future<bool> authUserApi(data) async {
    debugPrint('lgn authUserApi: ${data.username}');
    
    final OAuth oAuth = OAuth();
    String token = oAuth.getToken();

    debugPrint('lgn Mail: ${data.mail}');
    debugPrint('lgn Crypted password: ${data.md5Pw}');

    var response = await http.post(
      Uri.parse('http://87.106.171.75:3000/login'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'mail': data.mail,
        'password': data.md5Pw,
      }),
    );

    var userData;
    print('lgn Response status: ${response.statusCode}');
    print('lgn Response body: ${response.body}');
    debugPrint('--------- Hello response code : ${response.statusCode}');
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res.containsKey("id")) {
        userData = res;
        debugPrint('lgn --------- data : $userData');
      }
    } else {
      return false;
    }
    return Future.delayed(Duration(seconds: 0)).then((_) {
      if (userData["id"] > 0) {
        final User user = User();
        user.fromData(userData);
        return true;
      } else {
        return false;
      }
    });
  }

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:wishflix/Screens/main.dart' as rootPage;
import 'package:wishflix/core/di/app_routes.dart';
import 'package:wishflix/models/user_model.dart';


const users = const {
  'yan.parmentier@gmail.com': 'admin',
  'julien.guillaud00@gmail.com': 'admin',
  'axel.aubry69@gmail.com': 'admin',
  'driss.DC9@gmail.com': 'admin',
  'foucauden@gmail.com': 'admin',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 1000);


  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }






  Future<String?> _authUser(LoginData data) async {
    final User user = User();
    bool isConnectedSuccessfuly = await user.encodeAndAuthUserApi(data.name, data.password);

    debugPrint('--------- isConnectedSuccessfuly : $isConnectedSuccessfuly');
    if (isConnectedSuccessfuly == false) {
      return "Erreur, veuillez vérifier vos identifiants";
    }
    return Future.delayed(loginTime).then((_) {
      if (isConnectedSuccessfuly == true) {
        return null;
      } else {
        return "Erreur, veuillez vérifier vos identifiants";
      }
    });
  }

  skipLogin(context){
    Future.delayed(loginTime).then((_) {
      Navigator.pushNamed(context, kHomeRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('--------- LOGIN SCREEN isLogin :');

    final User user = User();
    if(user.isConnected == true){
      skipLogin(context);
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }else{

      return FlutterLogin(
        logo: AssetImage('assets/images/logo.png'),
        onLogin: _authUser,
        onSignup: _signupUser,
        onSubmitAnimationCompleted: () {
          Navigator.pushNamed(context, kHomeRoute);
        },
        onRecoverPassword: _recoverPassword,
        savedEmail: "admin@wishflix.com",
        savedPassword: "admin",
        messages: LoginMessages(
          loginButton: "Connexion",
          signupButton: "Inscription",
          forgotPasswordButton: "Mot de passe oublié ?",
          recoverPasswordButton: "Récupérer le mot de passe",
          goBackButton: "Retour",
          confirmPasswordError: "Les mots de passe ne correspondent pas",
          recoverPasswordIntro: "Entrez votre adresse email",
          recoverPasswordDescription:
              "Un email contenant un lien de récupération vous sera envoyé",
          recoverPasswordSuccess:
              "Un email contenant un lien de récupération vous a été envoyé",
          passwordHint: "Mot de passe",
          confirmPasswordHint: "Confirmer le mot de passe",
          confirmSignupButton: "S'inscrire",
          confirmRecoverIntro: "Votre mot de passe a été réinitialisé",
          signUpSuccess: "Inscription réussie",
          confirmSignupIntro: "Votre compte a été créé",
          confirmSignupSuccess: "Votre compte a été créé",
        ),
        theme: LoginTheme(
          primaryColor: Colors.black,
          accentColor: rootPage.appTheme.scaffoldBackgroundColor,
          errorColor: Colors.red,
          bodyStyle: TextStyle(
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline,
          ),
          textFieldStyle: TextStyle(
            color: Colors.white,
          ),
          buttonStyle: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          cardTheme: CardTheme(
            color: rootPage.appTheme.scaffoldBackgroundColor,
            elevation: 5,
            margin: EdgeInsets.only(top: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          ),
          inputTheme: InputDecorationTheme(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusColor: Colors.white,
            suffixIconColor: Colors.black.withOpacity(1),
            filled: true,
            iconColor: Colors.black,
            fillColor: Colors.black.withOpacity(.05),
            contentPadding: EdgeInsets.zero,
            errorStyle: TextStyle(
              backgroundColor: Colors.transparent,
              color: Colors.black,
            ),
            prefixIconColor: Colors.black,
            labelStyle: TextStyle(
              textBaseline: TextBaseline.alphabetic,
              fontSize: 12,
              color: Colors.black,
              backgroundColor: Colors.transparent,
            ),
            hintStyle: TextStyle(
              textBaseline: TextBaseline.alphabetic,
              fontSize: 12,
              color: Colors.black,
              backgroundColor: Colors.transparent,
            ),
            helperStyle: TextStyle(
              textBaseline: TextBaseline.alphabetic,
              fontSize: 12,
              color: Colors.black,
              backgroundColor: Colors.transparent,
            ),
            prefixStyle: TextStyle(
              textBaseline: TextBaseline.alphabetic,
              fontSize: 12,
              color: Colors.black,
              backgroundColor: Colors.transparent,
            ),
            suffixStyle: TextStyle(
              textBaseline: TextBaseline.alphabetic,
              fontSize: 12,
              color: Colors.black,
              backgroundColor: Colors.transparent,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 4),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 5),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 5),
            ),
          ),
          buttonTheme: LoginButtonTheme(
            splashColor: Colors.white,
            backgroundColor: Colors.black,
            highlightColor: Colors.black,
            elevation: 9.0,
            highlightElevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

  }
}

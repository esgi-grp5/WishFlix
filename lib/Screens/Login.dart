import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../Classes/HexColor.dart';
import 'main.dart';

const users = const {
  'yan.parmentier@gmail.com': 'admin',
  'julien.guillaud00@gmail.com': 'admin',
  'axel.aubry69@gmail.com': 'admin',
  'driss.DC9@gmail.com': 'admin',
  'foucauden@gmail.com': 'admin',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: AssetImage('assets/images/logo.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => RootScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      theme: LoginTheme(
        primaryColor: Colors.black,
        accentColor: HexColor("FFA31A"),
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
          color: HexColor("FFA31A"),
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

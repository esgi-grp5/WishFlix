
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishflix/Widgets/General/OAuth.dart';
import 'package:http/http.dart' as http;

class User {
  static final User _user = User._internal();
  late int id;
  late String username;
  late String mail;
  late String md5Pw;
  late bool isConnected;
  factory User() {
    return _user;
  }

  User._internal();

  void fromData(userData) {
    _user.id = userData["id"];
    _user.username = userData["username"];
    _user.mail = userData["mail"];
    _user.md5Pw = userData["password"];
  }

  Future<void> importFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt('id') ?? 0;
    debugPrint("userId = $userid");
    _user.id = prefs.getInt('id') ?? 0;
    _user.username =  prefs.getString('username') ?? "";
    _user.mail = prefs.getString('mail') ?? "";
    _user.md5Pw = prefs.getString('md5Pw') ?? "";
  }

  String getUsername() {
    return _user.username;
  }

  String getMail() {
    return _user.mail;
  }

  String getMD5Pw() {
    return _user.md5Pw;
  }

  int getId() {
    return _user.id;
  }

  void saveUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _user.username);
    prefs.setString('mail', _user.mail);
    prefs.setString('md5Pw', _user.md5Pw);
    prefs.setInt('id', _user.id);

    var tempId = prefs.getInt('id') ?? 0;
    debugPrint("Id session : $tempId");
  }

  void setIsConnected() {
    isConnected = true;
  }

  void disconnectUser() async {
    isConnected = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('mail');
    prefs.remove('md5Pw');
    prefs.remove('id');

  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<bool> encodeAndAuthUserApi(mail, password) async {
    _user.mail = mail;
    _user.md5Pw = generateMd5(password);
    return await _user.authUserApi();
  }

  Future<bool> authUserApi() async {
    debugPrint('lgn authUserApi: ${_user.username}');
    
    final OAuth oAuth = OAuth();
    String token = oAuth.getToken();

    debugPrint('lgn Mail: ${_user.mail}');
    debugPrint('lgn Crypted password: ${_user.md5Pw}');

    var response = await http.post(
      Uri.parse('http://87.106.171.75:3000/login'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'mail': _user.mail,
        'password': _user.md5Pw,
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
        debugPrint('lgn --------- _user : $userData');
      }
    } else {
      return false;
    }
    return Future.delayed(Duration(seconds: 0)).then((_) {
      if (userData["id"] > 0) {
        final User user = User();
        user.fromData(userData);
        user.setIsConnected();
        return true;
      } else {
        return false;
      }
    });
  }

}
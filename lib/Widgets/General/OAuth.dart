import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OAuth {
  static final OAuth _oAuth = OAuth._internal();
  late String token;
  factory OAuth() {
    return _oAuth;
  }

  OAuth._internal();

  Future<String> requestToken() async {
    // Get token from api OAuth

    var response = await http.post(
      Uri.parse('http://87.106.171.75:3000/oauth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'client_id': "flutter",
        'client_secret': "Xh7BY4MaPMwkmD-.3ULr"
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    debugPrint('--------- OAuth response code : ${response.statusCode}');
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res.containsKey("access_token")) {
        token = res["access_token"];
        debugPrint('--------- OAuth token : $token');
      }
    }
    return token;
  }

  String getToken() {
    return token;
  }
}

import 'dart:convert';
// import 'dart:math';

import 'package:wishflix/Screens/main.dart' as rootPage;

import 'package:flutter/material.dart';
import 'package:wishflix/Screens/ViewScreens/UniversalViewScreen.dart';
import 'package:wishflix/Widgets/DisplayItem/ImageTitle.dart';
import 'package:wishflix/Widgets/DisplayItem/RateSection.dart';
import 'package:wishflix/Widgets/DisplayItem/RowInformationsWithTitle.dart';
import 'package:wishflix/Widgets/DisplayItem/RowTimesWishlisted.dart';
import 'package:wishflix/Widgets/DisplayItem/RowWishListInfo.dart';
import 'package:wishflix/Widgets/General/OAuth.dart';
import 'package:wishflix/models/base_model.dart';
import 'package:http/http.dart' as http;
import 'package:wishflix/models/user_model.dart';
import 'package:wishflix/repository/serie_repository.dart';

class Serie extends Base {
  Serie(
      {required String image,
      required int id,
      required String genre,
      required String dateSortie,
      required String name,
      required String slug})
      : super(
            image: image,
            genre: genre,
            dateSortie: dateSortie,
            name: name,
            slug: slug,
            id: id);

  factory Serie.fromJson(Map<String, dynamic> json) {
    return Serie(
      id: json['id'],
      image: json['image'],
      genre: json['genre'],
      dateSortie: json['dateSortie'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toMap() {
    return super.toMap();
  }

  @override
  toString() {
    return super.toString();
  }

  @override
  Future<void> goToPage(context) async {
    List<Widget> screenBody = [];

    final OAuth oAuth = OAuth();
    String token = oAuth.getToken();
    int wishlistCount = 0;
    bool isWishlisted = false;

    User user = new User();

    var isAlreadyAdded = await http.get(
      Uri.http('87.106.171.75:3000', '/serie/wishlist/${user.id}'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
    // print('isAlreadyAdded status: ${isAlreadyAdded.statusCode}');
    // print('isAlreadyAdded body: ${isAlreadyAdded.body}');
    // debugPrint(
    // '--------- isAlreadyAdded response code : ${isAlreadyAdded.statusCode}');
    if (isAlreadyAdded.statusCode == 200) {
      List<dynamic> res = jsonDecode(isAlreadyAdded.body);
      for (var i = 0; i < res.length; i++) {
        if (res[i]['serie_id'] == this.id) {
          isWishlisted = true;
          break;
        }
      }
    }

    var response = await http.get(
      Uri.http('87.106.171.75:3000', '/serie/count/${this.id}'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    // debugPrint('--------- Hello response code : ${response.statusCode}');
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      wishlistCount = res['count'];
    }

    print('Serie ID : ${this.id}');
    var serieApi = await http.get(
      Uri.http(
          'tvmicroservices.azurewebsites.net', '/api/Tv/searchById/${this.id}'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
    // print('Serie getByID status: ${serieApi.statusCode}');
    // print('Serie getByID body: ${serieApi.body}');
    // debugPrint(
    // '--------- Serie getByID response code : ${serieApi.statusCode}');
    if (serieApi.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(serieApi.body);
      this.description = res['result_list'][0]['description'];
      // this.note = res['result_list']['vote_average'] / 2; // : change to note from api
      // this.description = "En attente API";
      this.note = 0; //En attente API
    }
    if (isWishlisted) {
      screenBody.add(ImageTitle(
          title: this.name,
          subTitle1: "2h23",
          subTitle2: this.genre,
          imageAssetUrl: this.image));
      screenBody.add(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: rootPage.appTheme.primaryColor,
            minimumSize: const Size.fromHeight(50), // NEW
          ),
          onPressed: () async {
            SerieRepository _serieRepository = SerieRepository();
            // print("Movie deleted: ${this.id}");
            _serieRepository.deleteSerie(this.id);
            final http.Response response = await http.delete(
                Uri.parse('http://87.106.171.75:3000/serie/wishlist'),
                headers: <String, String>{
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                },
                body: jsonEncode(
                  <String, int>{"username_id": user.id, "serie_id": this.id},
                ));
            print('Token: $token');
            print('Request: ${response.request}');
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');
            this.goToPage(context);
          },
          child: const Icon(
            Icons.remove,
            color: Colors.white,
          ),
        ),
      );
    } else {
      screenBody.add(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: rootPage.appTheme.backgroundColor,
            minimumSize: const Size.fromHeight(50), // NEW
          ),
          onPressed: () async {
            SerieRepository _serieRepository = SerieRepository();
            // print("Serie inserted: $this");
            _serieRepository.insertSerie(this);
            final http.Response response = await http.post(
                Uri.parse('http://87.106.171.75:3000/serie/wishlist'),
                headers: <String, String>{
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                },
                body: jsonEncode(
                  <String, int>{"username_id": user.id, "serie_id": this.id},
                ));
            print('Token: $token');
            print('Request: ${response.request}');
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');
            this.goToPage(context);
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      );
    }
    screenBody
        .add(RowWishListInfo(dateSortie: this.dateSortie, estVuText: "Non vu"));
    screenBody.add(RowInformationsWithTitle(
      informationTitle: "Synopsis",
      informationContent: this.description!,
    ));
    screenBody.add(RowTimesWishlisted(
        informationTitle: this.name, informationTimesAdded: wishlistCount));
    // Random random = new Random();
    // double randomNumber = random.nextInt(6).toDouble();
    screenBody.add(RateSection(
      starNumber: this.note!.toDouble(),
    ));

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UniversalViewScreen(
        screenTitle: "Série",
        screenBody: screenBody,
      );
    }));
  }
}

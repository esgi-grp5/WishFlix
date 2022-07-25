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
import 'package:wishflix/repository/movie_repository.dart';

class Movie extends Base {
  Movie(
      {required String image,
      required int id,
      required String genre,
      required String dateSortie,
      required String name,
      required String slug})
      : super(
            id: id,
            image: image,
            genre: genre,
            dateSortie: dateSortie,
            name: name,
            slug: slug);

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
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
    final OAuth oAuth = OAuth();
    String token = oAuth.getToken();
    int wishlistCount = 0;
    bool isWishlisted = false;

    User user = new User();

    var isAlreadyAdded = await http.get(
      Uri.http('87.106.171.75:3000', '/movie/wishlist/${user.id}'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
    print('isAlreadyAdded status: ${isAlreadyAdded.statusCode}');
    print('isAlreadyAdded body: ${isAlreadyAdded.body}');
    debugPrint(
        '--------- isAlreadyAdded response code : ${isAlreadyAdded.statusCode}');
    if (isAlreadyAdded.statusCode == 200) {
      List<dynamic> res = jsonDecode(isAlreadyAdded.body);
      for (var i = 0; i < res.length; i++) {
        if (res[i]['movie_id'] == this.id) {
          isWishlisted = true;
          break;
        }
      }
    }

    var movieCount = await http.get(
      Uri.http('87.106.171.75:3000', '/movie/count/${this.id}'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
    print('Movie count status: ${movieCount.statusCode}');
    print('Movie count body: ${movieCount.body}');
    debugPrint(
        '--------- Movie count response code : ${movieCount.statusCode}');
    if (movieCount.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(movieCount.body);
      wishlistCount = res['count'];
    }

    var movieApi = await http.get(
      Uri.http('moviemicroservices.azurewebsites.net',
          '/api/Movie/searchById/${this.id}'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
    print('Movie getByID status: ${movieApi.statusCode}');
    print('Movie getByID body: ${movieApi.body}');
    debugPrint(
        '--------- Movie getByID response code : ${movieApi.statusCode}');
    if (movieApi.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(movieApi.body);

      this.description = res['result_by_id'][0]['description'];
      this.note = res['result_by_id'][0]['vote_average'] / 2;
      // print('Vote averarge Movie : ${this.note}');
      // this.note = 0;
      // print('Vote averarge Movie :  ${res['result_by_id']['vote_average']}');
    }

    List<Widget> screenBody = [];
    debugPrint('--------- idMovie : $id');

    screenBody.add(ImageTitle(
        title: this.name,
        subTitle1: "2h23",
        subTitle2: this.genre,
        imageAssetUrl: this.image));
    if (isWishlisted) {
      screenBody.add(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: rootPage.appTheme.primaryColor,
            minimumSize: const Size.fromHeight(50), // NEW
          ),
          onPressed: () async {
            MovieRepository _movieRepository = MovieRepository();
            print("Movie deleted: ${this.id}");
            _movieRepository.deleteMovie(this.id);
            final http.Response response = await http.delete(
                Uri.parse('http://87.106.171.75:3000/movie/wishlist'),
                headers: <String, String>{
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                },
                body: jsonEncode(
                  <String, int>{"username_id": user.id, "movie_id": this.id},
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
            MovieRepository _movieRepository = MovieRepository();
            print("Movie inserted: $this");
            _movieRepository.insertMovie(this);
            final http.Response response = await http.post(
                Uri.parse('http://87.106.171.75:3000/movie/wishlist'),
                headers: <String, String>{
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                },
                body: jsonEncode(
                  <String, int>{"username_id": user.id, "movie_id": this.id},
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
        screenTitle: "Film",
        screenBody: screenBody,
      );
    }));
  }
}

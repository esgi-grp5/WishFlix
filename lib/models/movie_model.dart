import 'dart:convert';
import 'dart:math';

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
import 'package:wishflix/repository/movie_repository.dart';

class Movie extends Base {
  Movie(
      {required String image,
      int id = 0,
      required String genre,
      required String dateSortie,
      required String name,
      required String slug})
      : super(id:id, image: image, genre: genre, dateSortie: dateSortie, name: name, slug: slug);

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
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
  void goToPage(context) {
    final OAuth oAuth = OAuth();
    String token = oAuth.getToken();

    /*var response = await http.get(
      Uri.http('87.106.171.75:3000', '/movie/wishlist', {
        "id": "1",
      }),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json'
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    debugPrint('--------- Hello response code : ${response.statusCode}'); */

    List<Widget> screenBody = [];
    debugPrint('--------- idMovie : $id');

    screenBody.add(ImageTitle(
        title: this.name,
        subTitle1: "2h23",
        subTitle2: this.genre,
        imageAssetUrl: this.image));
    screenBody.add(
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: rootPage.appTheme.backgroundColor,
          minimumSize: const Size.fromHeight(50), // NEW
        ),
        onPressed: () async {
          MovieRepository _movieRepository = MovieRepository();
          _movieRepository.insertMovie(this);
          final http.Response response = await http.post(
              Uri.parse('http://87.106.171.75:3000/movie/wishlist'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(
                <String, int>{"username_id": 1, "movie_id": this.id},
              ));
          print('Token: $token');
          print('Request: ${response.request}');
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
    screenBody.add(
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: rootPage.appTheme.primaryColor,
          minimumSize: const Size.fromHeight(50), // NEW
        ),
        onPressed: () async {
          MovieRepository _movieRepository = MovieRepository();
          _movieRepository.deleteMovie(this.id);
          final http.Response response = await http.delete(
              Uri.parse('http://87.106.171.75:3000/movie/wishlist'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(
                <String, int>{"username_id": 1, "movie_id": this.id},
              ));
          print('Token: $token');
          print('Request: ${response.request}');
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
        },
        child: const Icon(
          Icons.remove,
          color: Colors.white,
        ),
      ),
    );
    screenBody
        .add(RowWishListInfo(dateSortie: this.dateSortie, estVuText: "Non vu"));
    screenBody.add(RowInformationsWithTitle(
      informationTitle: "Synopsis",
      informationContent:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ac facilisis ligula, sit amet lacinia erat. Suspendisse vel sagittis elit. Praesent suscipit nisl sit amet eros feugiat finibus. Nullam suscipit enim eleifend lorem rutrum, vel tempor enim faucibus. Vestibulum vitae facilisis lacus, eu ultrices felis. In scelerisque risus vitae justo convallis cursus. Maecenas ultrices eget tellus nec fermentum. Donec porttitor, leo sagittis aliquet efficitur, urna libero aliquam nibh, ut egestas justo lorem vitae nisi. Integer sed ornare lorem. Integer ornare augue eget erat aliquam hendrerit. Nulla consequat enim sit amet risus gravida, nec rutrum libero tincidunt. Ut non massa sed enim dictum volutpat. In diam justo, convallis vitae commodo vitae, pulvinar at nisl. Fusce ultricies non dolor at malesuada. \n Etiam gravida eleifend interdum. Integer et finibus mauris. Curabitur dapibus lacinia tincidunt. Nam ut quam at eros ultrices sodales. Suspendisse pellentesque ullamcorper pulvinar. Sed sed nisl enim. Pellentesque placerat ullamcorper velit sed tempus. Proin dictum volutpat fermentum. Aliquam erat volutpat. Suspendisse sollicitudin, tellus id luctus consectetur, est nulla iaculis ex, condimentum euismod dolor nulla sit amet lacus. Praesent placerat non velit ut dignissim. Maecenas porttitor sollicitudin turpis. Integer finibus eros eget velit aliquet, et consequat sapien posuere.",
    ));
    screenBody.add(RowTimesWishlisted(
        informationTitle: this.name, informationTimesAdded: 200));
    Random random = new Random();
    double randomNumber = random.nextInt(6).toDouble();
    screenBody.add(RateSection(
      starNumber: randomNumber,
    ));

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UniversalViewScreen(
        screenTitle: "Film",
        screenBody: screenBody,
      );
    }));
  }
}

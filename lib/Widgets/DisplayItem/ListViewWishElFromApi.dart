import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishflix/Widgets/DisplayItem/WishElement.dart';
import 'package:wishflix/Widgets/General/OAuth.dart';
// import 'package:wishflix/bloc/export_bloc.dart';
import 'package:wishflix/Screens/main.dart' as rootPage;
import 'package:wishflix/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:wishflix/models/serie_model.dart';

double? width;
double? height;

class ListViewWishElFromApi extends StatefulWidget {
  final String? typeElements;
  final String label;

  ListViewWishElFromApi({required this.typeElements, this.label = ""});
  @override
  _ListViewWishElFromApiState createState() => _ListViewWishElFromApiState();
}

class _ListViewWishElFromApiState extends State<ListViewWishElFromApi>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    String label = "";
    height = MediaQuery.of(context).size.longestSide;
    // BlocBuilder? bloc;
    FutureBuilder? futureBuilder;
    switch (widget.typeElements) {
      case "Series":
        label = "Séries";
        futureBuilder = futureBuilderFromFunction(requestSerieTrending());
        break;

      case "Movies":
        label = "Films";
        futureBuilder = futureBuilderFromFunction(requestMovieTrending());
        break;
      default:
        break;
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Spacer(),
              Text("AFFICHER PLUS",
                  style: TextStyle(
                      fontSize: 14, color: rootPage.appTheme.primaryColor))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
              height: height! * .25 < 170 ? height! * .25 : 170,
              //height: height! * .25 < 300 ? height! * .25 : 300,
              // child:
              // ConstrainedBox(
              //   constraints: BoxConstraints(maxHeight: 170, minHeight: height! * .13),
              child: futureBuilder),
        ),
      ],
    );
  }
}

futureBuilderFromFunction(futureFunction) {
  return FutureBuilder(
      future: futureFunction,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return WishElement(
                        image: snapshot.data[index].image,
                        titre: snapshot.data[index].name,
                        sousTitre: snapshot.data[index].genre,
                        date: snapshot.data[index].dateSortie,
                        base: snapshot.data[index]);
                  }));
        }
      });
}

Future<List<Movie>> requestMovieTrending() async {
  final OAuth oAuth = OAuth();
  String token = oAuth.getToken();

  var response = await http.get(
    Uri.parse(
        'https://moviemicroservices.azurewebsites.net/api/Movie/getTrending/day'),
    headers: <String, String>{
      'Authorization': 'Bearer $token',
    },
  );

  List<Movie> movieList = [];
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  debugPrint('--------- Hello response code : ${response.statusCode}');
  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);

    for (var i = 0; i < res["result_list"].length; i++) {
      var nbScreenshot = res["result_list"][i]["screenshots"].length;
      String coverImage;
      if (nbScreenshot > 0) {
        Random random = new Random();
        int randomNumber = random.nextInt(nbScreenshot);
        coverImage = res["result_list"][i]["screenshots"][randomNumber];
      } else {
        coverImage = 'assets/images/nodatafound.png';
      }

      Movie newMovie = Movie(
          dateSortie: res["result_list"][i]["release_date"],
          id: res["result_list"][i]["movie_id"],
          name: res["result_list"][i]["name"],
          slug: res["result_list"][i]["slug"],
          genre: res["result_list"][i]["genres"].join(", "),
          image: coverImage
          // image: "assets/images/Kerman.png" // temporaire
          );
      movieList.add(newMovie);
    }
    debugPrint('--------- movieList : $movieList');
  }
  return movieList;
}

Future<List<Serie>> requestSerieTrending() async {
  final OAuth oAuth = OAuth();
  String token = oAuth.getToken();

  var response = await http.get(
    Uri.parse(
        'https://tvmicroservices.azurewebsites.net/api/Tv/getTrending/day'),
    headers: <String, String>{
      'Authorization': 'Bearer $token',
    },
  );

  List<Serie> serieList = [];
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  debugPrint('--------- Hello response code : ${response.statusCode}');
  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);

    if (res.containsKey("Status") && res["Status"] == 200) {
      for (var i = 0; i < res["resultList"].length; i++) {
        var nbScreenshot = res["resultList"][i]["screenshots"].length;
        String coverImage;
        if (nbScreenshot > 0) {
          Random random = new Random();
          int randomNumber = random.nextInt(nbScreenshot);
          coverImage = res["resultList"][i]["screenshots"][randomNumber];
        } else {
          coverImage = 'assets/images/nodatafound.png';
        }

        Serie newSerie = Serie(
            dateSortie: res["resultList"][i]["release_date"],
            id: res["resultList"][i]["tv_id"],
            name: res["resultList"][i]["name"],
            slug: res["resultList"][i]["slug"],
            genre: res["resultList"][i]["genres"].join(", "),
            image: coverImage
            // image: "assets/images/Kerman.png" // temporaire
            );
        serieList.add(newSerie);
      }
      debugPrint('--------- serieList : $serieList');
    }
  }
  return serieList;
}

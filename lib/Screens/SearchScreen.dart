import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wishflix/Widgets/DisplayItem/SearchWishElement.dart';

import 'package:wishflix/Screens/main.dart' as rootPage;
import 'package:http/http.dart' as http;
import 'package:wishflix/Widgets/General/CustomBottomNavBar.dart';
import 'package:wishflix/Widgets/General/OAuth.dart';
import 'package:wishflix/models/movie_model.dart';
import 'package:wishflix/models/serie_model.dart';

double? width;
double? height;

int sel = 0;

final Color discountBackground = rootPage.appTheme.primaryColor;
final Color flightColor = rootPage.appTheme.primaryColor;
final Color chipBackground =
    rootPage.appTheme.secondaryHeaderColor.withOpacity(.2);
final Color borderColor = rootPage.appTheme.primaryColor.withAlpha(100);
String? contentType;
String? searchText;
int selectedType = 0;

class SearchScreen extends StatelessWidget {
  final String? searchTextTemp;
  final int? contentTypeIdTemp;
  SearchScreen({this.searchTextTemp, this.contentTypeIdTemp});

  @override
  Widget build(BuildContext context) {
    searchText = searchTextTemp;
    debugPrint('searchText: $searchText');

    selectedType = contentTypeIdTemp!;
    return Scaffold(
        bottomNavigationBar: CustomBottomNavBar(0),
        appBar: AppBar(
          backgroundColor: rootPage.appTheme.primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Recherche',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                // StackTop(),
                StackDown(),
              ],
            )));
    // children: <Widget>[StackTop(), StackDown()],
  }
}

class StackDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 25,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // height: height! * .25 < 170 ? height! * .25 : 170,
          //height: height! * .25 < 300 ? height! * .25 : 300,
          // child:
          // ConstrainedBox(
          //   constraints: BoxConstraints(maxHeight: 170, minHeight: height! * .13),
          child: FutureBuilder(
              future: searchOnApi(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else {
                  return Container(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return SearchWishElement(
                                image: snapshot.data[index].image,
                                titre: snapshot.data[index].name,
                                sousTitre: snapshot.data[index].genre,
                                date: snapshot.data[index].dateSortie,
                                base: snapshot.data[index]);
                          }));
                }
              }),
        ),
      ),
    ]);
  }
}

searchOnApi() async {
  print('Search on API : $searchText');

  switch (selectedType) {
    case 0:
      // "movie";
      final OAuth oAuth = OAuth();
      String token = oAuth.getToken();

      var response = await http.get(
        Uri.parse(
            'https://moviemicroservices.azurewebsites.net/api/Movie/searchByName/$searchText'),
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

        if (res.containsKey("status") && res["status"] == 200) {
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
                // description: res["result_list"][i]["description"],
                // note: res["result_list"][i]["vote_average"],
                genre: res["result_list"][i]["genres"].join(", "),
                image: coverImage
                // image: "assets/images/Kerman.png" // temporaire
                );
            movieList.add(newMovie);
          }
          debugPrint('--------------------------');
          debugPrint('--------------------------');
          debugPrint('-------------------------- movieList : $movieList');
        }
      }
      return movieList;
    case 1:
      // "tv";
      final OAuth oAuth = OAuth();
      String token = oAuth.getToken();

      var response = await http.get(
        Uri.parse(
            'https://tvmicroservices.azurewebsites.net/api/Tv/searchByName/$searchText'),
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

        if (res.containsKey("status") && res["status"] == 200) {
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

            Serie newSerie = Serie(
                dateSortie: res["result_list"][i]["release_date"],
                id: res["result_list"][i]["tv_id"],
                name: res["result_list"][i]["name"],
                slug: res["result_list"][i]["slug"],
                // description: res["result_list"][i]["description"],
                // note: res["result_list"][i]["vote_average"],
                genre: res["result_list"][i]["genres"].join(", "),
                image: coverImage
                // image: "assets/images/Kerman.png" // temporaire
                );
            serieList.add(newSerie);
          }
          debugPrint('--------------------------');
          debugPrint('--------------------------');
          debugPrint('-------------------------- serieList : $serieList');
        }
      }
      return serieList;
    case 2:
      // "music";
      break;
    case 3:
      // "game";
      break;
    case 4:
      // "all";
      break;
    default:
      break;
  }
}

// class StackTop extends StatefulWidget {
//   @override
//   _StackTop createState() => _StackTop();
// }

// class _StackTop extends State<StackTop> {
//   @override
//   Widget build(BuildContext context) {
//     width = MediaQuery.of(context).size.shortestSide;
//     height = MediaQuery.of(context).size.longestSide;

//     return Stack(
//       children: <Widget>[
//         Opacity(
//           //semi red clippath with more height and with 0.5 opacity
//           opacity: 1,
//           child: ClipPath(
//             clipper: Clipper08(), //set our custom wave clipper
//             child: Container(
//               // color: HexColor("000000"),
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                     rootPage.appTheme.primaryColor,
//                     rootPage.appTheme.scaffoldBackgroundColor
//                   ])),
//               height: (height! * .6) + 10 - 85, //400
//               width: width,
//             ),
//           ),
//         ),
//         ClipPath(
//           clipper: Clipper08(),
//           child: Container(
//             color: rootPage.appTheme.primaryColor,
//             height: height! * .6 - 85, //400
//             width: width,

//             child: Column(
//               children: <Widget>[
//                 Column(
//                   children: <Widget>[
//                     SizedBox(
//                       height: height! * .1,
//                     ),
//                     Container(
//                       width: 335,
//                       padding: EdgeInsets.symmetric(horizontal: 32.0),
//                       child: Material(
//                         elevation: 5.0,
//                         borderRadius: BorderRadius.all(Radius.circular(30)),
//                         child: TextField(
//                           controller: c,
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             color: Colors.black,
//                           ),
//                           cursorColor: rootPage.appTheme.primaryColor,
//                           decoration: InputDecoration(
//                               border: InputBorder.none,
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 32, vertical: 13),
//                               suffixIcon: Material(
//                                 child: InkWell(
//                                   child: Icon(
//                                     Icons.search,
//                                     color: Colors.black,
//                                   ),
//                                   onTap: () {
//                                     // Refresh results
//                                     searchOnApi();
//                                   },
//                                 ),
//                                 elevation: 2.0,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(30)),
//                               )),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: height! * .05,
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     InkWell(
//                       child: Choice08(
//                           icon: Icons.filter_alt_off,
//                           text: "TOUS",
//                           selected: selectedType == 4),
//                       onTap: () {
//                         setState(() {
//                           selectedType = 4;
//                         });
//                       },
//                     ),
//                     SizedBox(
//                       width: width! * 0.055,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: height! * .015,
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     InkWell(
//                       child: Choice08(
//                           icon: Icons.movie_outlined,
//                           text: "Films",
//                           selected: selectedType == 0),
//                       onTap: () {
//                         setState(() {
//                           selectedType = 0;
//                         });
//                       },
//                     ),
//                     SizedBox(
//                       width: width! * 0.055,
//                     ),
//                     InkWell(
//                       child: Choice08(
//                           icon: Icons.theaters,
//                           text: "Séries",
//                           selected: selectedType == 1),
//                       onTap: () {
//                         setState(() {
//                           selectedType = 1;
//                         });
//                       },
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: height! * 0.015,
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     InkWell(
//                       child: Choice08(
//                           icon: Icons.music_note,
//                           text: "Musiques",
//                           selected: selectedType == 2),
//                       onTap: () {
//                         setState(() {
//                           selectedType = 2;
//                         });
//                       },
//                     ),
//                     SizedBox(
//                       width: width! * 0.055,
//                     ),
//                     InkWell(
//                       child: Choice08(
//                           icon: Icons.gamepad,
//                           text: "Jeux",
//                           selected: selectedType == 3),
//                       onTap: () {
//                         setState(() {
//                           selectedType = 3;
//                         });
//                       },
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishflix/Widgets/DisplayItem/WishElement.dart';
import 'package:wishflix/Widgets/General/OAuth.dart';
import 'package:wishflix/bloc/export_bloc.dart';
import 'package:wishflix/Screens/main.dart' as rootPage;
import 'package:wishflix/models/movie_model.dart';
import 'package:http/http.dart' as http;


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
    BlocBuilder? bloc;
    FutureBuilder? futureBuilder;
    switch (widget.typeElements) {
      case "Musics":
        label = "Musique";
        bloc = BlocBuilder<MusicBloc, MusicState>(
          buildWhen: (previous, current) => previous is MusicListLoadingState,
          builder: (context, state) {
            if (state is MusicListSuccessState) {
              return ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: state.musics
                    .map(
                      (music) => WishElement(
                          image: music.image,
                          titre: music.name,
                          sousTitre: music.artist,
                          date: music.dateSortie,
                          base: music),
                    )
                    .toList(),
              );
            }
            if (state is MusicListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MusicListErrorState) {
              return Center(child: Text(state.error));
            }
            return Container();
          },
        );
        break;

      case "Series":
        label = "Séries";
        bloc = BlocBuilder<SerieBloc, SerieState>(
          buildWhen: (previous, current) => previous is SerieListLoadingState,
          builder: (context, state) {
            if (state is SerieListSuccessState) {
              return ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: state.series
                    .map(
                      (serie) => WishElement(
                          image: serie.image,
                          titre: serie.name,
                          sousTitre: serie.genre,
                          date: serie.dateSortie,
                          base: serie),
                    )
                    .toList(),
              );
            }
            if (state is SerieListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SerieListErrorState) {
              return Center(child: Text(state.error));
            }
            return Container();
          },
        );
        break;
      case "Games":
        label = "Jeux";
        bloc = BlocBuilder<GameBloc, GameState>(
          buildWhen: (previous, current) => previous is GameListLoadingState,
          builder: (context, state) {
            if (state is GameListSuccessState) {
              return ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: state.games
                    .map(
                      (game) => WishElement(
                          image: game.image,
                          titre: game.name,
                          sousTitre: game.genre,
                          date: game.dateSortie,
                          base: game),
                    )
                    .toList(),
              );
            }
            if (state is GameListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GameListErrorState) {
              return Center(child: Text(state.error));
            }
            return Container();
          },
        );
        break;
      case "Movies":
        label = "Films";
        futureBuilder = FutureBuilder(
          future: requestMovieTrending(),
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
                        base: snapshot.data[index]
                      );
                      }));
            }
          }
          );
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



 Future<List<Movie>> requestMovieTrending() async {
    final OAuth oAuth = OAuth();
    String token = oAuth.getToken();

    var response = await http.get(
      Uri.parse('https://moviemicroservices.azurewebsites.net/api/Movie/getTrending/day'),
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

      if (res.containsKey("Status") && res["Status"] == 200) {

        for(var i = 0 ; i < res["resultList"].length ; i++){
          debugPrint('--------- FOR : $i');
          Movie newMovie = Movie(
            dateSortie: res["resultList"][i]["release_date"],
            id: res["resultList"][i]["movie_id"],
            name: res["resultList"][i]["name"],
            genre: res["resultList"][i]["genre"].toString(),
            // image: res["resultList"][i]["screenshots"][0]
            image: "assets/images/Kerman.png" // temporaire
          );
          movieList.add(newMovie);
          debugPrint('--------- data : $newMovie');
        }
      }
    }
    return Future.delayed(Duration(seconds: 0)).then((_) {
      return movieList;
    });
  }

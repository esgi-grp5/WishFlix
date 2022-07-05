// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Screens
import 'package:wishflix/Screens/main.dart' as rootPage;
// General
import 'package:wishflix/HexColor.dart';
import 'package:wishflix/app_routes.dart';
import 'package:wishflix/core/di/locator.dart';
// Classes
import 'package:wishflix/Widgets/CustomBottomNavBar.dart';
// Widgets
import 'package:wishflix/Widgets/Choice08.dart';
import 'package:wishflix/Widgets/Clipper08.dart';
import 'package:wishflix/Widgets/WishElement.dart';
// Blocs
import 'package:wishflix/bloc/export_bloc.dart';
// Models
import 'package:wishflix/models/game_model.dart';
import 'package:wishflix/models/movie_model.dart';
import 'package:wishflix/models/music_model.dart';
import 'package:wishflix/models/serie_model.dart';
// Repository
import 'package:wishflix/repository/game_repository.dart';
import 'package:wishflix/repository/movie_repository.dart';
import 'package:wishflix/repository/music_repository.dart';
import 'package:wishflix/repository/serie_repository.dart';

double? width;
double? height;

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final MovieBloc movieBloc = locator<MovieBloc>();
  final SerieBloc serieBloc = locator<SerieBloc>();
  final MusicBloc musicBloc = locator<MusicBloc>();
  final GameBloc gameBloc = locator<GameBloc>();

  loadAllBloc() {
    movieBloc.add(GetAllMoviesEvent());
    serieBloc.add(GetAllSeriesEvent());
    musicBloc.add(GetAllMusicsEvent());
    gameBloc.add(GetAllGamesEvent());
  }

  @override
  void initState() {
    loadAllBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            WishListTop(),
            myMovieList,
            mySerieList,
            myMusicList,
            myGameList
          ],
        ),
      ),
    );
  }
}

var selectedType = 4;

class WishListTop extends StatefulWidget {
  @override
  _WishListTop createState() => _WishListTop();
}

class _WishListTop extends State<WishListTop> {
  TextEditingController c = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          //semi red clippath with more height and with 0.5 opacity
          opacity: 1,
          child: ClipPath(
            clipper: Clipper08(), //set our custom wave clipper
            child: Container(
              // color: HexColor("000000"),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    rootPage.appTheme.primaryColor,
                    rootPage.appTheme.scaffoldBackgroundColor
                  ])),
              // height: height! * .65 < 460 ? height! * .65 : 510, //400
              height: (height! * .6) + 10,
            ),
          ),
        ),
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            color: rootPage.appTheme.primaryColor,
            height: height! * .6, //400
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height! / 16,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png',
                        height: 50,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height! / 16,
                ),
                Text(
                  'Ma liste',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: HexColor("ff9900"),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height! * 0.0375),
                SizedBox(
                  height: height! * 0.025,
                ),
                // myMovieList,
                // myGameList
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Choice08(
                          icon: Icons.filter_alt_off,
                          text: "TOUS",
                          selected: selectedType == 4),
                      onTap: () {
                        setState(() {
                          selectedType = 4;
                        });
                      },
                    ),
                    SizedBox(
                      width: width! * 0.055,
                    ),
                  ],
                ),
                SizedBox(
                  height: height! * .015,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: Choice08(
                          icon: Icons.movie_outlined,
                          text: "Films",
                          selected: selectedType == 0),
                      onTap: () {
                        setState(() {
                          selectedType = 0;
                        });
                      },
                    ),
                    SizedBox(
                      width: width! * 0.055,
                    ),
                    InkWell(
                      child: Choice08(
                          icon: Icons.theaters,
                          text: "Séries",
                          selected: selectedType == 1),
                      onTap: () {
                        setState(() {
                          selectedType = 1;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: height! * 0.015,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: Choice08(
                          icon: Icons.music_note,
                          text: "Musiques",
                          selected: selectedType == 2),
                      onTap: () {
                        setState(() {
                          selectedType = 2;
                        });
                      },
                    ),
                    SizedBox(
                      width: width! * 0.055,
                    ),
                    InkWell(
                      child: Choice08(
                          icon: Icons.gamepad,
                          text: "Jeux",
                          selected: selectedType == 3),
                      onTap: () {
                        setState(() {
                          selectedType = 3;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
            right: 20,
            top: 65,
            child: Container(
              child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, kNotifRoute);
                  }),
            )),
      ],
    );
  }
}

var myMovieList = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // SizedBox(
          //   width: width! * 0.05,
          // ),
          Text(
            "Vos films",
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
        child: BlocBuilder<MovieBloc, MovieState>(
          buildWhen: (previous, current) => previous is MovieListLoadingState,
          builder: (context, state) {
            if (state is MovieListSuccessState) {
              return ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: state.movies
                    .map(
                      (movie) => WishElement(
                        image: movie.image,
                        titre: movie.name,
                        sousTitre: movie.genre,
                        date: movie.dateSortie,
                      ),
                    )
                    .toList(),
              );
            }
            if (state is MovieListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MovieListErrorState) {
              return Center(child: Text(state.error));
            }
            return Container();
          },
        ),
      ),
    ),
  ],
);
var mySerieList = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // SizedBox(
          //   width: width! * 0.05,
          // ),
          Text(
            "Vos séries",
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
        child: BlocBuilder<SerieBloc, SerieState>(
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
                      ),
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
        ),
      ),
    ),
  ],
);
var myGameList = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // SizedBox(
          //   width: width! * 0.05,
          // ),
          Text(
            "Vos jeux",
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
        child: BlocBuilder<GameBloc, GameState>(
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
                      ),
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
        ),
      ),
    ),
  ],
);
var myMusicList = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // SizedBox(
          //   width: width! * 0.05,
          // ),
          Text(
            "Vos jeux",
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
        child: BlocBuilder<MusicBloc, MusicState>(
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
                        date: music.annee,
                      ),
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
        ),
      ),
    ),
  ],
);

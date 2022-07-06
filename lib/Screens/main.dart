import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishflix/Widgets/General/OAuth.dart';
// Classes
import 'package:wishflix/core/di/HexColor.dart';
import 'package:wishflix/core/di/app_routes.dart';
import 'package:wishflix/bloc/game/game_bloc.dart';
import 'package:wishflix/bloc/movie/movie_bloc.dart';
import 'package:wishflix/bloc/music/music_bloc.dart';
import 'package:wishflix/bloc/serie/serie_bloc.dart';
import 'package:wishflix/core/di/locator.dart';
import 'package:wishflix/repository/game_repository.dart';
import 'package:wishflix/repository/movie_repository.dart';
import 'package:wishflix/repository/music_repository.dart';
import 'package:wishflix/repository/serie_repository.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final MovieBloc movieBloc = locator<MovieBloc>();
  final SerieBloc serieBloc = locator<SerieBloc>();
  final GameBloc gameBloc = locator<GameBloc>();
  final MusicBloc musicBloc = locator<MusicBloc>();

  final OAuth oAuth = OAuth();

  @override
  Widget build(BuildContext context) {
    debugPrint('--------- MAIN SCREEN main.dart');

    oAuth.requestToken();

    final GameBloc gameBloc = locator<GameBloc>();
    final MovieRepository _movieRepository = MovieRepository();
    final SerieRepository _serieRepository = SerieRepository();
    final MusicRepository _musicRepository = MusicRepository();
    final GameRepository _gameRepository = GameRepository();
    _gameRepository.insertDefaultData();
    _movieRepository.insertDefaultData();
    _serieRepository.insertDefaultData();
    _musicRepository.insertDefaultData();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WishList',
        theme: appTheme,
        initialRoute: '/',
        routes: kRoutes,
        builder: (_, widget) {
          return MultiBlocProvider(providers: [
            BlocProvider<MovieBloc>(
              create: (_) => movieBloc,
            ),
            BlocProvider<SerieBloc>(
              create: (_) => serieBloc,
            ),
            BlocProvider<GameBloc>(
              create: (_) => gameBloc,
            ),
            BlocProvider<MusicBloc>(
              create: (_) => musicBloc,
            ),
          ], child: widget ?? Container());
        });
  }
}

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("FFA31A"),
  backgroundColor: HexColor("FFA31A"),
  primaryColor: HexColor("000000"),
  /* Colors.tealAccent,*/
  secondaryHeaderColor: HexColor("000000"),
  /* Colors.teal*/
  fontFamily: 'Gotham',
);

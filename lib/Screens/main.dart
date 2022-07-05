import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Classes
import 'package:wishflix/HexColor.dart';
import 'package:wishflix/app_routes.dart';
import 'package:wishflix/bloc/game/game_bloc.dart';
import 'package:wishflix/bloc/movie/movie_bloc.dart';
import 'package:wishflix/bloc/music/music_bloc.dart';
import 'package:wishflix/bloc/serie/serie_bloc.dart';
import 'package:wishflix/core/di/locator.dart';

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

  @override
  Widget build(BuildContext context) {
    debugPrint('--------- MAIN SCREEN main.dart');
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

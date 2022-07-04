import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Classes
import 'package:wishflix/Classes/HexColor.dart';
import 'package:wishflix/app_routes.dart';
import 'package:wishflix/bloc/movie/movie_bloc.dart';
import 'package:wishflix/core/di/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final MovieBloc movieBloc = locator<MovieBloc>();

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
            )
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

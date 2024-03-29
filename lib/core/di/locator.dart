import 'package:get_it/get_it.dart';
import 'package:wishflix/bloc/game/game_bloc.dart';
import 'package:wishflix/bloc/movie/movie_bloc.dart';
import 'package:wishflix/bloc/music/music_bloc.dart';
import 'package:wishflix/bloc/serie/serie_bloc.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => MovieBloc());
  locator.registerLazySingleton(() => SerieBloc());
  locator.registerLazySingleton(() => GameBloc());
  locator.registerLazySingleton(() => MusicBloc());
}

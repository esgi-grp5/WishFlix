import 'package:equatable/equatable.dart';

import '../../models/movie_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

//inital movie state
class InitialMovieState extends MovieState {
  @override
  List<Object> get props => [];
}

// movie loading state
class MovieListLoadingState extends MovieState {
  @override
  List<Object> get props => [];
}
// movieList success state
class MovieListSuccessState extends MovieState {
  final List<Movie> movies;

  const MovieListSuccessState(this.movies);

  @override
  List<Object> get props => [movies];
}

//movieList error state
class MovieListErrorState extends MovieState {
  final String error;

  const MovieListErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// movieList success state
class MovieSuccessState extends MovieState {
  final Movie movie;

  const MovieSuccessState(this.movie);

  @override
  List<Object> get props => [movie];
}

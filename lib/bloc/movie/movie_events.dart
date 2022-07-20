import 'package:equatable/equatable.dart';

import '../../models/movie_model.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

//add movie event
class AddMovieEvent extends MovieEvent {
  final Movie movie;

  const AddMovieEvent({required this.movie});

  @override
  List<Object> get props => [Movie];
}

// remove movie event
class RemoveMovieEvent extends MovieEvent {
  final int movieId;

  const RemoveMovieEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

//get all movies event
class GetAllMoviesEvent extends MovieEvent {
  @override
  List<Object> get props => [];
}


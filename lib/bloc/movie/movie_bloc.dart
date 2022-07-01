import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishflix/bloc/movie/movie_events.dart';
import 'package:wishflix/bloc/movie/movie_states.dart';
import 'package:wishflix/models/movie_model.dart';
import 'package:wishflix/repository/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(InitialMovieState()) {
    on<GetAllMoviesEvent>(_onGetAllMovies);
  }

  final MovieRepository _movieRepository = MovieRepository();

  // lier les states à l'evenement GetAllMoviesEvent
  void _onGetAllMovies(GetAllMoviesEvent event, Emitter<MovieState> emit) async {
    // state de loading va etre écouté par l'UI
    emit(MovieListLoadingState());
    try {
      //get data from repository
      List<Movie> movies = await _movieRepository.getAllMovies();

      //put data in state to be communicated to UI
      emit(MovieListSuccessState(movies));
    } catch (e) {
      //put error in state to be communicated to UI
      emit(MovieListErrorState(e.toString()));
    }
  }
}

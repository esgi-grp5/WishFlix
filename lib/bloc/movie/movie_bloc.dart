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
  void _onGetAllMovies(
      GetAllMoviesEvent event, Emitter<MovieState> emit) async {
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

  // Future<List<Movie>> requestTrending() async {
  //   final OAuth oAuth = OAuth();
  //   String token = oAuth.getToken();

  //   var response = await http.get(
  //     Uri.parse('https://moviemicroservices.azurewebsites.net/api/Movie/getTrending/day'),
  //     headers: <String, String>{
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   var movieList;
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //   debugPrint('--------- Hello response code : ${response.statusCode}');
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> res = jsonDecode(response.body);

  //     if (res.containsKey("status") && res["status"] == 200) {
  //       for(var i = 0 ; i < res["resultList"].length ; i++){
  //         Movie newMovie = Movie(
  //           dateSortie: res["resultList"][i]["release_date"],
  //           id: res["resultList"][i]["movie_id"],
  //           name: res["resultList"][i]["name"],
  //           genre: res["resultList"][i]["genre"].toString(),
  //           image: res["resultList"][i]["screenshots"][0]
  //         );
  //         debugPrint('--------- data : $newMovie');
  //         movieList.add(newMovie);
  //       }
  //     }
  //   }
  //   return Future.delayed(Duration(seconds: 0)).then((_) {
  //     return movieList;
  //   });
  // }


import 'package:wishflix/providers/movie_cache_provider.dart';

import '../models/movie_model.dart';

class MovieRepository {
  final MovieCacheProvider _cache = MovieCacheProvider();

  Future<int> insertMovie(Movie movie) async {
    return await _cache.insertMovie(movie);
  }

  Future<int> updateMovie(Movie movie) async {
    return await _cache.updateMovie(movie);
  }

  Future<List<Movie>> getAllMovies() async {
    return await _cache.getAllMovies();
  }

  Future<Map<String, dynamic>?> getMovies(int id) async {
    return await _cache.getMovies(id);
  }

  Future<int> deleteMovie(int id) async {
    return await _cache.deleteMovie(id);
  }

  closeDatabase() async {
    await _cache.closeDatabase();
  }
}

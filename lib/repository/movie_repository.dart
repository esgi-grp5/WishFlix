import 'package:wishflix/models/movie_model.dart';
import 'package:wishflix/providers/movie_cache_provider.dart';

class MovieRepository {
  final MovieCacheProvider _cache = MovieCacheProvider();

  Future<int> insertDefaultData() async {
    return await _cache.insertDefaultData();
  }

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

  Future<void> deleteAll() async {
    return await _cache.deleteAll();
  }

  closeDatabase() async {
    await _cache.closeDatabase();
  }
}

import 'package:wishflix/models/serie_model.dart';
import 'package:wishflix/providers/serie_cache_provider.dart';

class SerieRepository {
  final SerieCacheProvider _cache = SerieCacheProvider();

  Future<int> insertSerie(Serie serie) async {
    return await _cache.insertSerie(serie);
  }

  Future<int> updateSerie(Serie serie) async {
    return await _cache.updateSerie(serie);
  }

  Future<List<Serie>> getAllSeries() async {
    return await _cache.getAllSeries();
  }

  Future<Map<String, dynamic>?> getSeries(int id) async {
    return await _cache.getSeries(id);
  }

  Future<int> deleteSerie(int id) async {
    return await _cache.deleteSerie(id);
  }

  Future<void> deleteAll() async {
    return await _cache.deleteAll();
  }

  closeDatabase() async {
    await _cache.closeDatabase();
  }
}

import 'package:wishflix/models/game_model.dart';
import 'package:wishflix/providers/game_cache_provider.dart';

class GameRepository {
  final GameCacheProvider _cache = GameCacheProvider();

  Future<int> insertDefaultData() async {
    return await _cache.insertDefaultData();
  }

  Future<int> insertGame(Game game) async {
    return await _cache.insertGame(game);
  }

  Future<int> updateGame(Game game) async {
    return await _cache.updateGame(game);
  }

  Future<List<Game>> getAllGames() async {
    return await _cache.getAllGames();
  }

  Future<void> deleteAll() async {
    return await _cache.deleteAll();
  }

  Future<Map<String, dynamic>?> getGames(int id) async {
    return await _cache.getGames(id);
  }

  Future<int> deleteGame(int id) async {
    return await _cache.deleteGame(id);
  }

  closeDatabase() async {
    await _cache.closeDatabase();
  }
}

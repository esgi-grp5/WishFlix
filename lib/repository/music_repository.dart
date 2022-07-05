import 'package:wishflix/models/music_model.dart';
import 'package:wishflix/providers/music_cache_provider.dart';

class MusicRepository {
  final MusicCacheProvider _cache = MusicCacheProvider();

  Future<int> insertMusic(Music music) async {
    return await _cache.insertMusic(music);
  }

  Future<int> updateMusic(Music music) async {
    return await _cache.updateMusic(music);
  }

  Future<List<Music>> getAllMusics() async {
    return await _cache.getAllMusics();
  }

  Future<Map<String, dynamic>?> getMusics(int id) async {
    return await _cache.getMusics(id);
  }

  Future<int> deleteMusic(int id) async {
    return await _cache.deleteMusic(id);
  }

  closeDatabase() async {
    await _cache.closeDatabase();
  }
}

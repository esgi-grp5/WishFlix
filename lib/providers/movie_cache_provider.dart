import 'package:sqflite/sqflite.dart';
import 'package:wishflix/models/movie_model.dart';

class MovieCacheProvider {
  static const _name = "MoviesDatabase.db";
  static const _version = 2;
  late Database database;
  static const tableName = 'movies';

  initDatabase() async {
    database = await openDatabase(_name, version: _version,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE $tableName (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    image TEXT,
                    name TEXT,
                    genre TEXT,
                    dateSortie TEXT
                    )''');
    });
  }

  Future<int> insertMovie(Movie movie) async {
    await initDatabase();
    return await database.insert(tableName, movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateMovie(Movie movie) async {
    await initDatabase();
    return await database.update(tableName, movie.toMap(),
        where: "id = ?",
        whereArgs: [movie.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Movie>> getAllMovies() async {
    await initDatabase();
    var result = await database.query(tableName);
    return result.map((e) => Movie.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getMovies(int id) async {
    await initDatabase();
    var result =
        await database.query(tableName, where: "id = ?", whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }

  Future<int> deleteMovie(int id) async {
    await initDatabase();
    print("id: $id");
    return await database.delete(tableName, where: "id = ?", whereArgs: [id]);
    // return await database.rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
  }

  closeDatabase() async {
    await database.close();
  }
}
import 'package:sqflite/sqflite.dart';
import 'package:wishflix/models/game_model.dart';

class GameCacheProvider {
  static const _name = "GamesDatabase.db";
  static const _version = 2;
  late Database database;
  static const tableName = 'games';

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

  Future<int> insertGame(Game game) async {
    await initDatabase();
    return await database.insert(tableName, game.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateGame(Game game) async {
    await initDatabase();
    return await database.update(tableName, game.toMap(),
        where: "id = ?",
        whereArgs: [game.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Game>> getAllGames() async {
    await initDatabase();
    var result = await database.query(tableName);
    return result.map((e) => Game.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getGames(int id) async {
    await initDatabase();
    var result =
        await database.query(tableName, where: "id = ?", whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }

  Future<int> deleteGame(int id) async {
    await initDatabase();
    print("id: $id");
    return await database.delete(tableName, where: "id = ?", whereArgs: [id]);
    // return await database.rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
  }

  closeDatabase() async {
    await database.close();
  }
}

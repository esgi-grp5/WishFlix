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
                    slug TEXT,
                    genre TEXT,
                    description TEXT,
                    note INTEGER,
                    dateSortie TEXT
                    )''');
    });
  }

  /* Future<int> insertDefaultData() async {
    await initDatabase();
    Game game = Game(
      image: "assets/images/Kerman.png",
      name: "Call of duty",
      slug: "Call of duty",
      genre: "Action",
      dateSortie: "Fevrier 2019",
    );
    await insertGame(game);
    game = Game(
      image: "assets/images/Kerman.png",
      name: "Call of duty",
      slug: "Call of duty",
      genre: "Action",
      dateSortie: "Fevrier 2019",
    );
    return await insertGame(game);
  } */

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

  Future<void> deleteAll() async {
    await initDatabase();
    await database.execute("drop table if exists $tableName");
    return await database.execute('''CREATE TABLE $tableName (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    image TEXT,
                    name TEXT,
                    slug TEXT,
                    genre TEXT,
                    description TEXT,
                    note INTEGER,
                    dateSortie TEXT
                    )''');
  }

  closeDatabase() async {
    await database.close();
  }
}

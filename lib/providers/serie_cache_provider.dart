import 'package:sqflite/sqflite.dart';
import 'package:wishflix/models/serie_model.dart';

class SerieCacheProvider {
  static const _name = "SeriesDatabase.db";
  static const _version = 2;
  late Database database;
  static const tableName = 'series';

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

  Future<int> insertSerie(Serie serie) async {
    await initDatabase();
    return await database.insert(tableName, serie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateSerie(Serie serie) async {
    await initDatabase();
    return await database.update(tableName, serie.toMap(),
        where: "id = ?",
        whereArgs: [serie.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Serie>> getAllSeries() async {
    await initDatabase();
    var result = await database.query(tableName);
    return result.map((e) => Serie.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> getSeries(int id) async {
    await initDatabase();
    var result =
        await database.query(tableName, where: "id = ?", whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }

  Future<int> deleteSerie(int id) async {
    await initDatabase();
    print("id: $id");
    return await database.delete(tableName, where: "id = ?", whereArgs: [id]);
    // return await database.rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
  }

  closeDatabase() async {
    await database.close();
  }
}
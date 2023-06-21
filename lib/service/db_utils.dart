import 'dart:async';
import 'package:fizansekerleme_k/utils/Seker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbUtils {

  static final DbUtils _dbUtils = DbUtils._internal();

  DbUtils._internal();

  factory DbUtils() {
    return _dbUtils;
  }

  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String path = join(await getDatabasesPath(), 'sekerlerim.db');
    var dbSekerler = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbSekerler;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE sekerler(id INTEGER PRIMARY KEY, isim TEXT,aciklama TEXT, fiyat INTEGER)");
  }

  Future<void> deleteTable() async {
    final Database? db = await this.db;
    db?.delete('sekerler');
  }

  Future<void> insertSeker(Seker seker) async {
    final Database? db = await this.db;
    await db?.insert(
      'sekerler',
      seker.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Seker>> sekerler() async {
    // Get a reference to the database.
    final Database? db = await this.db;
    // Query the table for all The Dogs.
    final List<Map<String, Object?>>? maps = await db?.query('sekerler');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps!.length, (i) {
      return Seker(
        id: int.parse(maps[i]['id'].toString()),
        isim: maps[i]['isim'].toString(),
        aciklama: maps[i]['aciklama'].toString(),
        fiyat: int.parse(maps[i]['fiyat'].toString()),
      );
    });
  }

  Future<void> updateSeker(Seker seker) async {
    final db = await this.db;
    await db?.update(
      'sekerler',
      seker.toMap(),
      where: "id = ?",
      whereArgs: [seker.id],
    );
  }

  Future<void> deleteSeker(int id) async {
    final db = await this.db;
    await db?.delete(
      'sekerler',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
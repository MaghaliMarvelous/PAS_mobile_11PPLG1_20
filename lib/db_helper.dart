import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  static Database? _db;
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'pas_favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            key TEXT PRIMARY KEY,
            name TEXT,
            price REAL,
            raw TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertFavorite(String key, Map<String, dynamic> raw,
      {String? name, double? price}) async {
    final database = await db;
    await database.insert(
      'favorites',
      {
        'key': key,
        'name': name,
        'price': price,
        'raw': jsonEncode(raw),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(String key) async {
    final database = await db;
    await database.delete('favorites', where: 'key = ?', whereArgs: [key]);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final database = await db;
    final rows = await database.query('favorites', orderBy: 'name');
    return rows.map((r) {
      final raw = r['raw'] != null ? jsonDecode(r['raw'] as String) as Map<String, dynamic> : <String, dynamic>{};
      return {
        'id': r['key'],
        'name': r['name'],
        'price': r['price'],
        ...raw,
      };
    }).toList();
  }

  Future<bool> exists(String key) async {
    final database = await db;
    final rows = await database.query('favorites', where: 'key = ?', whereArgs: [key], limit: 1);
    return rows.isNotEmpty;
  }
}
import 'package:sqflite/sqflite.dart';
import 'package:ui_error_app/model/exceptions.dart';
import 'package:ui_error_app/model/tourism.dart';

class DatabaseService {
  static const String _databaseName = 'users.db';
  static const String _tableName = 'place';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE $_tableName(
        id INTEGER,
        name TEXT,
        description TEXT,
        address TEXT,
        like INTEGER,
        image TEXT
      )""");
  }

  Future<Database> _initializeDb() async {
    try {
      return await openDatabase(
        _databaseName,
        version: _version,
        onCreate: (Database database, int version) async {
          await createTables(database);
        },
      );
    } on DatabaseException {
      throw AppException("Cannot initialize the database.");
    }
  }

  Future<int> insertItem(Place place) async {
    try {
      final db = await _initializeDb();

      final data = place.toMap();
      final id = await db.insert(
        _tableName,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } on DatabaseException {
      throw AppException("Cannot save the data.");
    }
  }

  Future<List<Place>> getAllItems() async {
    try {
      final db = await _initializeDb();
      final results = await db.query(_tableName, orderBy: "id");

      return results.map((result) => Place.fromMap(result)).toList();
    } on DatabaseException {
      throw AppException("Cannot get all the data.");
    }
  }

  Future<int> removeItem(int id) async {
    try {
      final db = await _initializeDb();

      final result = await db.delete(
        _tableName,
        where: "id = ?",
        whereArgs: [id],
      );
      return result;
    } on DatabaseException {
      throw AppException("Cannot remove the data.");
    }
  }

  Future<int> updateItem(int id, Place place) async {
    try {
      final db = await _initializeDb();

      final data = place.toMap();
      final result = await db.update(
        _tableName,
        data,
        where: "id = ?",
        whereArgs: [id],
      );
      return result;
    } on DatabaseException {
      throw AppException("Cannot update the data.");
    }
  }

  Future<Place?> getItemById(int id) async {
    try {
      final db = await _initializeDb();
      final results = await db.query(
        _tableName,
        where: "id = ?",
        whereArgs: [id],
        limit: 1,
      );

      return results.isNotEmpty ? Place.fromMap(results.first) : null;
    } on DatabaseException {
      throw AppException("Cannot get the data by this id($id).");
    }
  }
}

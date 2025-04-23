import 'package:database_app/model/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const String _databaseName = 'users.db';
  static const String _tableName = 'user';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        first_name TEXT,
        last_name TEXT
      )""");
  }

  Future<Database> _initializeDb() async {
    return await openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<int> insertItem(User user) async {
    final db = await _initializeDb();

    final data = user.toMap();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<User>> getAllItems() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName, orderBy: "id");

    return results.map((result) => User.fromMap(result)).toList();
  }

  Future<int> removeItem(int id) async {
    final db = await _initializeDb();

    final result = await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  Future<int> updateItem(int id, User user) async {
    final db = await _initializeDb();

    final data = user.toMap();
    final result = await db.update(
      _tableName,
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  Future<User> getItemById(int id) async {
    final db = await _initializeDb();
    final results = await db.query(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    return results.map((result) => User.fromMap(result)).first;
  }
}

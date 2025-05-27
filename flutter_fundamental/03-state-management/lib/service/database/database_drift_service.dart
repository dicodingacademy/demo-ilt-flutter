import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ui_error_app/model/exceptions.dart';
// Menggunakan alias untuk model Place agar tidak bentrok dengan class Place yang mungkin dihasilkan Drift
import 'package:ui_error_app/model/tourism.dart';
import 'package:ui_error_app/service/database_service.dart';

// Ini akan menjadi file yang dihasilkan oleh build_runner
part 'database_drift_service.g.dart';

// 1. Definisikan Tabel (menggantikan CREATE TABLE SQL)
// Nama class (Places) akan menjadi nama tabel (places) secara default di Drift.
// Ini sesuai dengan _tableName = 'place' sebelumnya.
@DataClassName(
  'PlaceData',
) // Memberi nama class data yang dihasilkan Drift agar tidak bentrok jika ada
class PlaceTable extends Table {
  // Kolom-kolom tabel
  IntColumn get id => integer()(); // Sesuai dengan 'id INTEGER'
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get address => text()();
  IntColumn get like => integer()();
  TextColumn get image => text()();

  @override
  Set<Column> get primaryKey => {id}; // Menetapkan 'id' sebagai primary key
}

// 2. Definisikan Database
@DriftDatabase(tables: [PlaceTable])
class AppDatabase extends _$AppDatabase {
  static const String _databaseName =
      'places.db'; // Nama database dari kode asli
  static const int _dbVersion = 1; // Versi database dari kode asli

  // Konstruktor untuk pengujian atau konfigurasi khusus
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => _dbVersion; // Versi skema database

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: _databaseName,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
      ),
    );
  }
}

// 3. DatabaseService yang telah dimigrasikan
class DatabaseDriftService implements DatabaseService {
  // Instance AppDatabase, bisa dibuat singleton atau di-inject
  // Di sini kita buat static agar hanya ada satu instance AppDatabase
  static final AppDatabase _appDatabase = AppDatabase();

  final AppDatabase _db;

  // Konstruktor default akan menggunakan instance _appDatabase
  DatabaseDriftService() : _db = _appDatabase;

  // Konstruktor untuk memungkinkan injeksi AppDatabase (berguna untuk testing)
  DatabaseDriftService.internal(this._db);

  // Method createTables tidak lagi diperlukan, Drift menangani pembuatan tabel.
  // Method _initializeDb juga tidak lagi diperlukan.

  @override
  Future<int> insertItem(Place place) async {
    try {
      // Mapping dari Place ke PlacesCompanion (digunakan Drift untuk insert/update)
      final companion = PlaceTableCompanion(
        id: Value(place.id), // 'id' dari model Place Anda
        name: Value(place.name),
        description: Value(place.description),
        address: Value(place.address),
        like: Value(place.like),
        image: Value(place.image),
      );

      // Menggunakan InsertMode.insertOrReplace untuk mencocokkan ConflictAlgorithm.replace
      // Method insert pada Drift akan mengembalikan nilai primary key (jika INTEGER PRIMARY KEY)
      // atau jumlah baris yang terpengaruh. Karena 'id' adalah INTEGER PRIMARY KEY,
      // ini akan mengembalikan nilai 'id' yang dimasukkan/diganti.
      return await _db
          .into(_db.placeTable)
          .insert(companion, mode: InsertMode.insertOrReplace);
    } catch (e) {
      // Anda bisa menangkap DriftSpecificException jika perlu, atau Exception umum
      // print('Error inserting item: $e'); // Untuk debugging
      throw AppException("Cannot save the data.");
    }
  }

  @override
  Future<List<Place>> getAllItems() async {
    try {
      // Mengambil semua item dari tabel 'places', diurutkan berdasarkan 'id'
      final query = _db.select(_db.placeTable)
        ..orderBy([(t) => OrderingTerm(expression: t.id)]);
      final results = await query.get();

      // Mapping dari List<PlaceData> (class yang dihasilkan Drift) ke List<Place>
      return results.map((driftPlaceData) {
        return Place(
          id: driftPlaceData.id,
          name: driftPlaceData.name,
          description: driftPlaceData.description,
          address: driftPlaceData.address,
          like: driftPlaceData.like,
          image: driftPlaceData.image,
        );
      }).toList();
    } catch (e) {
      // print('Error getting all items: $e'); // Untuk debugging
      throw AppException("Cannot get all the data.");
    }
  }

  @override
  Future<int> removeItem(int id) async {
    try {
      // Menghapus item berdasarkan 'id'. Method 'go()' menjalankan delete dan mengembalikan jumlah baris yang terpengaruh.
      final statement = _db.delete(_db.placeTable)
        ..where((tbl) => tbl.id.equals(id));
      return await statement.go();
    } catch (e) {
      // print('Error removing item: $e'); // Untuk debugging
      throw AppException("Cannot remove the data.");
    }
  }

  @override
  Future<int> updateItem(int itemId, Place place) async {
    try {
      // Mapping dari Place ke PlacesCompanion untuk update
      // Perhatikan bahwa 'id' tidak di-set di companion untuk update, karena 'id' digunakan di klausa 'where'.
      final companion = PlaceTableCompanion(
        name: Value(place.name),
        description: Value(place.description),
        address: Value(place.address),
        like: Value(place.like),
        image: Value(place.image),
      );

      // Update item berdasarkan 'itemId'. Method 'write()' menjalankan update dan mengembalikan jumlah baris yang terpengaruh.
      final statement = _db.update(_db.placeTable)
        ..where((tbl) => tbl.id.equals(itemId));
      return await statement.write(companion);
    } catch (e) {
      // print('Error updating item: $e'); // Untuk debugging
      throw AppException("Cannot update the data.");
    }
  }

  @override
  Future<Place?> getItemById(int id) async {
    try {
      // Mengambil satu item berdasarkan 'id'
      final query =
          _db.select(_db.placeTable)
            ..where((tbl) => tbl.id.equals(id))
            ..limit(1);
      final driftPlaceData = await query.getSingleOrNull();

      if (driftPlaceData != null) {
        // Mapping dari PlaceData (dihasilkan Drift) ke Place
        return Place(
          id: driftPlaceData.id,
          name: driftPlaceData.name,
          description: driftPlaceData.description,
          address: driftPlaceData.address,
          like: driftPlaceData.like,
          image: driftPlaceData.image,
        );
      }
      return null;
    } catch (e) {
      // print('Error getting item by id: $e'); // Untuk debugging
      throw AppException("Cannot get the data by this id($id).");
    }
  }
}

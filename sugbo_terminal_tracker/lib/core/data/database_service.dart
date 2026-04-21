import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Centralized SQLite database service used across all features.
///
/// Provides a single shared [Database] instance backed by the
/// bundled `assets/routes.db` file.  Every feature that needs
/// local data should obtain the database from here instead of
/// managing its own connection.
class DatabaseService {
  // Singleton
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  /// Returns the shared [Database], initialising it on first call.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('routes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    final exists = await databaseExists(path);

    if (!exists) {
      debugPrint('[DatabaseService] Creating fresh copy from asset…');

      // Ensure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy the bundled asset into the writable database path
      final ByteData data = await rootBundle.load(join('assets', 'routes.db'));
      final List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      debugPrint('[DatabaseService] Opening existing database.');
    }

    return await openDatabase(path);
  }

  /// Closes the database connection.  Call during app teardown
  /// if needed.
  Future<void> close() async {
    final db = await instance.database;
    db.close();
    _database = null;
  }
}

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/route_model.dart';

class RouteDatabaseHelper {
  static final RouteDatabaseHelper instance = RouteDatabaseHelper._init();
  static Database? _database;

  RouteDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('routes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Check if the database exists
    final exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join('assets', 'routes.db'));
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    return await openDatabase(path);
  }

  Future<List<RouteModel>> getRoutes(String origin, String destination) async {
    final db = await instance.database;
    final maps = await db.query(
      'routes',
      where: 'origin = ? AND destination = ?',
      whereArgs: [origin, destination],
    );

    if (maps.isNotEmpty) {
      return maps.map((map) => RouteModel.fromMap(map)).toList();
    } else {
      // Return a generic route if it's not explicitly in our SQLite database mock setup
      return [
        RouteModel(
          title: 'GENERIC BUS',
          subtitle: 'Regular operations',
          path: '\$origin → \$destination',
          duration: 'Direct · ~45 min',
          price: '₱20.00',
          comparison: '',
          status: 'Every ~15 min',
          isFree: false,
        ),
      ];
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}

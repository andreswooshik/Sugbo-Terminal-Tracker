import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/trip_model.dart';

class SavingsDatabaseHelper {
  static final SavingsDatabaseHelper instance = SavingsDatabaseHelper._init();
  static Database? _database;

  SavingsDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('savings.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Force override local DB from assets for development
    print("Deleting old local savings database to force refresh...");
    await deleteDatabase(path);

    print("Creating fresh copy from asset...");

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join('assets', 'savings.db'));
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );

    // Write and flush the bytes
    await File(path).writeAsBytes(bytes, flush: true);

    return await openDatabase(path);
  }

  Future<List<TripModel>> getAllTrips() async {
    final db = await instance.database;
    final maps = await db.query('trips', orderBy: 'timestamp DESC');

    return maps.map((map) => TripModel.fromMap(map)).toList();
  }

  Future<List<TripModel>> getTripsByProvider(String provider) async {
    final db = await instance.database;
    final maps = await db.query(
      'trips',
      where: 'provider = ?',
      whereArgs: [provider],
    );

    return maps.map((map) => TripModel.fromMap(map)).toList();
  }

  Future<void> addTrip(TripModel trip) async {
    final db = await instance.database;
    await db.insert('trips', trip.toMap());
  }

  Future<Map<String, double>> getTotalSavings() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT SUM(savings_amount) as total FROM trips');
    
    if (result.isNotEmpty && result.first['total'] != null) {
      return {'total': result.first['total'] as double};
    }
    return {'total': 0.0};
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}

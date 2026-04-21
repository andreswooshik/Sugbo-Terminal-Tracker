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

    // ==========================================
    // FOR DEVELOPMENT: Force override local DB
    // This ensures that the app always loads the freshest `routes.db` from your assets!
    // ==========================================
    print("Deleting old local database to force refresh...");
    await deleteDatabase(path);

    print("Creating fresh copy from asset...");

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

    return await openDatabase(path);
  }

  Future<List<RouteModel>> getRoutes(String origin, String destination) async {
    final db = await instance.database;

    // Check if both origin and destination are BRT stations
    final brtOrigin = await db.query(
      'brt_stations',
      where: 'station_name = ?',
      whereArgs: [origin],
    );

    final brtDest = await db.query(
      'brt_stations',
      where: 'station_name = ?',
      whereArgs: [destination],
    );

    List<RouteModel> brtRoutes = [];
    if (brtOrigin.isNotEmpty && brtDest.isNotEmpty) {
      double kmOrigin = brtOrigin.first['km_marker'] as double;
      double kmDest = brtDest.first['km_marker'] as double;
      double distance = (kmOrigin - kmDest).abs();

      final now = DateTime.now();
      final hour = now.hour;

      bool isLibrengSakay =
          (hour >= 6 && hour < 9) || (hour >= 17 && hour < 20);

      double regularFare = 0.0;
      double studentFare = 0.0;

      if (!isLibrengSakay) {
        regularFare = 18.0;
        studentFare = 14.40;

        if (distance > 5.0) {
          double extraKm = (distance - 5.0).ceilToDouble(); // Per extra km
          regularFare += (2.97 * extraKm);
          studentFare += (2.38 * extraKm);
        }
      }

      brtRoutes = [
        RouteModel(
          title: 'BRT',
          subtitle: isLibrengSakay
              ? 'Libreng Sakay Time!'
              : 'CBRT Standard Route (${distance.toStringAsFixed(1)} km)',
          path: '$origin → CBRT Stops → $destination',
          duration:
              '${(distance * 4).toStringAsFixed(0)} mins', // roughly 4 mins per km
          price: isLibrengSakay
              ? '₱0.00'
              : '₱${regularFare.toStringAsFixed(2)}',
          comparison: isLibrengSakay
              ? 'Save ₱${regularFare.toStringAsFixed(2)}!'
              : 'Student: ₱${studentFare.toStringAsFixed(2)}',
          status: 'Every 10-15 mins',
          isFree: isLibrengSakay,
        ),
      ];
    }

    final maps = await db.query(
      'routes',
      where: 'origin = ? AND destination = ?',
      whereArgs: [origin, destination],
    );

    List<RouteModel> standardRoutes = [];
    if (maps.isNotEmpty) {
      standardRoutes = maps.map((map) => RouteModel.fromMap(map)).toList();
    } else if (brtRoutes.isEmpty) {
      standardRoutes = [
        RouteModel(
          title: 'GENERIC BUS',
          subtitle: 'Regular operations',
          path: '$origin → $destination',
        ),
      ];
    }

    return [...brtRoutes, ...standardRoutes];
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}

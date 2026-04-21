import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/schedule_model.dart';

class ScheduleDatabaseHelper {
  static final ScheduleDatabaseHelper instance = ScheduleDatabaseHelper._init();
  static Database? _database;

  ScheduleDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('schedules.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Force override local DB from assets for development
    print("Deleting old local schedules database to force refresh...");
    await deleteDatabase(path);

    print("Creating fresh copy from asset...");

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join('assets', 'schedules.db'));
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );

    // Write and flush the bytes
    await File(path).writeAsBytes(bytes, flush: true);

    return await openDatabase(path);
  }

  Future<List<ScheduleModel>> getAllSchedules() async {
    final db = await instance.database;
    final maps = await db.query('schedules', orderBy: 'provider_badge ASC');

    return maps.map((map) => ScheduleModel.fromMap(map)).toList();
  }

  Future<List<ScheduleModel>> getSchedulesByProvider(String provider) async {
    final db = await instance.database;
    final maps = await db.query(
      'schedules',
      where: 'provider_badge LIKE ?',
      whereArgs: ['%$provider%'],
    );

    return maps.map((map) => ScheduleModel.fromMap(map)).toList();
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}

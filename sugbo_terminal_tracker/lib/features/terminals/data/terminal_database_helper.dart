import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/terminal_wait_model.dart';

class TerminalDatabaseHelper {
  static final TerminalDatabaseHelper instance = TerminalDatabaseHelper._init();
  static Database? _database;

  TerminalDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('terminals.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Force override local DB from assets for development
    print("Deleting old local terminals database to force refresh...");
    await deleteDatabase(path);

    print("Creating fresh copy from asset...");

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join('assets', 'terminals.db'));
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );

    // Write and flush the bytes
    await File(path).writeAsBytes(bytes, flush: true);

    return await openDatabase(path);
  }

  Future<List<TerminalWaitModel>> getAllTerminals() async {
    final db = await instance.database;
    final maps = await db.query('terminals', orderBy: 'name ASC');

    return maps.map((map) => TerminalWaitModel.fromMap(map)).toList();
  }

  Future<TerminalWaitModel?> getTerminalByName(String name) async {
    final db = await instance.database;
    final maps = await db.query(
      'terminals',
      where: 'name = ?',
      whereArgs: [name],
    );

    if (maps.isEmpty) return null;
    return TerminalWaitModel.fromMap(maps.first);
  }

  Future<void> updateWaitTime(String terminalName, String waitTime) async {
    final db = await instance.database;
    await db.update(
      'terminals',
      {'wait_time': waitTime, 'last_updated': DateTime.now().toIso8601String()},
      where: 'name = ?',
      whereArgs: [terminalName],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}

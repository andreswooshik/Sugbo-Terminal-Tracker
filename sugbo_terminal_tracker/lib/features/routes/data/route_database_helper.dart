// lib/services/route_database_helper.dart
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

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    // Only copy from assets if the database doesn't exist yet
    if (!await databaseExists(path)) {
      print('📦 First run: Copying database from assets...');

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      final data = await rootBundle.load('assets/$fileName');
      final bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print('📂 Using existing database at $path');
    }

    // Open as read-only (the database is static)
    return await openDatabase(path, readOnly: true);
  }

  // ---------------------------------------------------------------------------
  // Check if current time falls within a free ride window
  // ---------------------------------------------------------------------------
  bool _isWithinFreeWindow(String? startStr, String? endStr) {
    if (startStr == null || endStr == null) return false;
    if (startStr == '00:00' && endStr == '23:59') return true;

    final now = DateTime.now();
    final startParts = startStr.split(':');
    final endParts = endStr.split(':');

    if (startParts.length < 2 || endParts.length < 2) return false;

    final start = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(startParts[0]),
      int.parse(startParts[1]),
    );
    final end = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(endParts[0]),
      int.parse(endParts[1]),
    );

    return now.isAfter(start) && now.isBefore(end);
  }

  // ---------------------------------------------------------------------------
  // Get next departure time from a comma-separated schedule string
  // ---------------------------------------------------------------------------
  String _getNextDeparture(String? scheduleStr) {
    if (scheduleStr == null || scheduleStr.isEmpty) return '';

    final now = DateTime.now();
    final times = scheduleStr.split(',');

    for (final t in times) {
      final parts = t.trim().split(':');
      if (parts.length < 2) continue;

      final departure = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      if (departure.isAfter(now)) {
        final hour = departure.hour;
        final ampm = hour >= 12 ? 'PM' : 'AM';
        final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        final displayMinute = departure.minute.toString().padLeft(2, '0');
        return 'Next: $displayHour:$displayMinute $ampm';
      }
    }
    return 'No more trips today';
  }

  bool _isWeekend() {
    final day = DateTime.now().weekday;
    return day == DateTime.saturday || day == DateTime.sunday;
  }

  // ---------------------------------------------------------------------------
  // Calculate BRT fare based on distance
  // ---------------------------------------------------------------------------
  _BrtFare _calculateBrtFare(double distance) {
    double regular = 18.0;
    double student = 14.40;
    if (distance > 5.0) {
      final extraKm = (distance - 5.0).ceilToDouble();
      regular += 2.97 * extraKm;
      student += 2.38 * extraKm;
    }
    return _BrtFare(regular: regular, student: student, distance: distance);
  }

  // ---------------------------------------------------------------------------
  // Main route query – shows both free and paid options
  // ---------------------------------------------------------------------------
  Future<List<RouteModel>> getRoutes(String origin, String destination) async {
    final db = await database;
    final isWeekend = _isWeekend();

    final maps = await db.query(
      'routes',
      where: 'origin = ? AND destination = ?',
      whereArgs: [origin, destination],
    );

    final List<RouteModel> results = [];

    for (final map in maps) {
      final isFreeInDB = (map['isFree'] as int) == 1;
      final freeStart = map['freeTimeStart'] as String?;
      final freeEnd = map['freeTimeEnd'] as String?;
      final scheduleStr = isWeekend
          ? map['scheduleWeekend'] as String?
          : map['scheduleWeekday'] as String?;
      final frequency =
          map['frequency'] as String? ??
          map['status'] as String? ??
          'Every 20-30 mins';
      final nextDep = _getNextDeparture(scheduleStr);
      final statusFull = [
        frequency,
        if (nextDep.isNotEmpty) nextDep,
      ].join(' · ');

      if (isFreeInDB) {
        final currentlyInWindow = _isWithinFreeWindow(freeStart, freeEnd);

        // Add the free version
        results.add(
          RouteModel.fromMap({
            ...map,
            'status': statusFull,
            'isFree': currentlyInWindow ? 1 : 0,
            'subtitle': currentlyInWindow
                ? '${map['subtitle']} (ACTIVE NOW)'
                : '${map['subtitle']} (Window: $freeStart-$freeEnd)',
          }),
        );

        // For libreng_sakay routes, also add a paid alternative (if one exists)
        // We'll look for a matching paid route with the same origin/destination.
        if (map['routeType'] == 'libreng_sakay') {
          // Try to find the corresponding paid MyBus route
          final paidMaps = await db.query(
            'routes',
            where:
                'origin = ? AND destination = ? AND isFree = 0 AND routeType = ?',
            whereArgs: [origin, destination, 'regular'],
          );
          if (paidMaps.isNotEmpty) {
            final paidMap = paidMaps.first;
            final paidSchedule = isWeekend
                ? paidMap['scheduleWeekend'] as String?
                : paidMap['scheduleWeekday'] as String?;
            final paidNext = _getNextDeparture(paidSchedule);
            final paidStatus = [
              paidMap['frequency'] ?? paidMap['status'] ?? 'Operational',
              if (paidNext.isNotEmpty) paidNext,
            ].join(' · ');
            results.add(RouteModel.fromMap({...paidMap, 'status': paidStatus}));
          } else {
            // Fallback: create a generic paid alternative
            results.add(
              RouteModel.fromMap({
                ...map,
                'title': 'MyBus (Regular)',
                'price': _getEstimatedPrice(origin, destination),
                'isFree': 0,
                'subtitle': 'Regular Paid Alternative',
                'status': statusFull,
              }),
            );
          }
        }
      } else {
        // Regular paid route
        results.add(RouteModel.fromMap({...map, 'status': statusFull}));
      }
    }

    // Add BRT dynamic calculation if both stations exist in brt_stations
    await _addBrtOptions(db, origin, destination, results);

    // Fallback if no routes found
    if (results.isEmpty) {
      results.add(
        RouteModel(
          title: 'Standard Jeepney',
          subtitle: 'Mixed Traffic Route',
          path: '$origin → $destination',
          duration: 'Direct · ~45 min',
          price: '₱15.00',
          comparison: 'Alternative Option',
          status: 'Frequent',
          isFree: false,
        ),
      );
    }

    // Sort: free options first, then by price (low to high)
    results.sort((a, b) {
      if (a.isFree && !b.isFree) return -1;
      if (!a.isFree && b.isFree) return 1;
      // If both free or both paid, sort by numeric price
      final aPrice = _extractNumericPrice(a.price);
      final bPrice = _extractNumericPrice(b.price);
      return aPrice.compareTo(bPrice);
    });

    return results;
  }

  // Helper to get an estimated price for fallback paid alternative
  String _getEstimatedPrice(String origin, String destination) {
    // Simple heuristic based on common routes
    if ((origin.contains('Anjo') && destination.contains('SM Cebu')) ||
        (origin.contains('SM Cebu') && destination.contains('Anjo'))) {
      return '₱50.00';
    }
    if (origin.contains('Airport') || destination.contains('Airport')) {
      return '₱50.00';
    }
    return '₱30.00';
  }

  double _extractNumericPrice(String price) {
    final match = RegExp(
      r'(\d+(\.\d+)?)',
    ).firstMatch(price.replaceAll(',', ''));
    return match != null ? double.parse(match.group(1)!) : 999.0;
  }

  Future<void> _addBrtOptions(
    Database db,
    String origin,
    String destination,
    List<RouteModel> results,
  ) async {
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

    if (brtOrigin.isNotEmpty && brtDest.isNotEmpty) {
      final kmOrigin = (brtOrigin.first['km_marker'] as num).toDouble();
      final kmDest = (brtDest.first['km_marker'] as num).toDouble();
      final distance = (kmOrigin - kmDest).abs();

      final isBrtFreeTime =
          _isWithinFreeWindow('06:00', '09:00') ||
          _isWithinFreeWindow('17:00', '20:00');

      final fare = _calculateBrtFare(distance);

      if (isBrtFreeTime) {
        results.add(
          RouteModel(
            title: 'CBRT Bus (FREE)',
            subtitle: 'Libreng Sakay Program (Active)',
            path: '$origin → CBRT Stops → $destination',
            duration: '~${(distance * 3.5).round()} mins',
            price: '₱0.00',
            comparison: 'Save ₱${fare.regular.toStringAsFixed(2)}!',
            status: 'Every 10-15 mins',
            isFree: true,
          ),
        );
      }

      results.add(
        RouteModel(
          title: 'CBRT Bus',
          subtitle: 'Standard Route Fare',
          path: '$origin → CBRT Stops → $destination',
          duration: '~${(distance * 3.5).round()} mins',
          price: '₱${fare.regular.toStringAsFixed(2)}',
          comparison: 'Student: ₱${fare.student.toStringAsFixed(2)}',
          status: 'Daily Operations',
          isFree: false,
        ),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Additional helper queries
  // ---------------------------------------------------------------------------
  Future<List<RouteModel>> getRoutesFromOrigin(String origin) async {
    final db = await database;
    final isWeekend = _isWeekend();
    final maps = await db.query(
      'routes',
      where: 'origin = ?',
      whereArgs: [origin],
    );

    return maps.map((map) {
      final scheduleStr = isWeekend
          ? map['scheduleWeekend'] as String?
          : map['scheduleWeekday'] as String?;
      final nextDep = _getNextDeparture(scheduleStr);
      final status = map['status'] ?? 'Operational';
      final statusFull = nextDep.isNotEmpty ? '$status · $nextDep' : status;
      return RouteModel.fromMap({...map, 'status': statusFull});
    }).toList();
  }

  Future<List<RouteModel>> getActiveLibrengSakayRoutes() async {
    final db = await database;
    final maps = await db.query('routes', where: "isFree = 1");
    final List<RouteModel> active = [];
    for (final map in maps) {
      if (_isWithinFreeWindow(
        map['freeTimeStart'] as String?,
        map['freeTimeEnd'] as String?,
      )) {
        active.add(RouteModel.fromMap(map));
      }
    }
    return active;
  }

  Future<List<String>> getAllOrigins() async {
    final db = await database;
    final maps = await db.query(
      'routes',
      columns: ['origin'],
      distinct: true,
      orderBy: 'origin',
    );
    return maps.map((m) => m['origin'] as String).toList();
  }

  Future<List<String>> getDestinationsForOrigin(String origin) async {
    final db = await database;
    final maps = await db.query(
      'routes',
      columns: ['destination'],
      where: 'origin = ?',
      whereArgs: [origin],
      distinct: true,
      orderBy: 'destination',
    );
    return maps.map((m) => m['destination'] as String).toList();
  }

  Future<List<RouteModel>> getAllSchedules({
    String routeTypeFilter = 'all',
  }) async {
    final db = await database;
    List<Map<String, Object?>> maps;
    if (routeTypeFilter == 'all') {
      maps = await db.query('routes');
    } else {
      maps = await db.query(
        'routes',
        where: 'routeType = ?',
        whereArgs: [routeTypeFilter],
      );
    }
    return maps.map((map) => RouteModel.fromMap(map)).toList();
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}

// Internal class for fare calculation result
class _BrtFare {
  final double regular;
  final double student;
  final double distance;
  _BrtFare({
    required this.regular,
    required this.student,
    required this.distance,
  });
}

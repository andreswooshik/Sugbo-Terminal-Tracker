import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final dbPath = 'assets/routes.db';

  // Delete the old database if it exists to start fresh
  if (File(dbPath).existsSync()) {
    File(dbPath).deleteSync();
  }

  print('Generating local database at: $dbPath');

  // Open the database (this creates a new file)
  final db = sqlite3.open(dbPath);

  // Create the table structure
  db.execute('''
    CREATE TABLE routes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      origin TEXT NOT NULL,
      destination TEXT NOT NULL,
      title TEXT NOT NULL,
      subtitle TEXT NOT NULL,
      path TEXT NOT NULL,
      duration TEXT NOT NULL,
      price TEXT NOT NULL,
      comparison TEXT NOT NULL,
      status TEXT NOT NULL,
      isFree INTEGER NOT NULL
    )
  ''');

  db.execute('''
    CREATE TABLE brt_stations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      station_name TEXT NOT NULL,
      km_marker REAL NOT NULL
    )
  ''');

  final insertBrtStmt = db.prepare('''
    INSERT INTO brt_stations (station_name, km_marker)
    VALUES (?, ?)
  ''');

  insertBrtStmt.execute(['Il Corso', 0.0]);
  insertBrtStmt.execute(['SM Seaside', 1.7]);
  insertBrtStmt.execute(['CSBT', 5.0]);
  insertBrtStmt.execute(['Fuente', 7.7]);
  insertBrtStmt.execute(['Capitol', 8.6]);
  insertBrtStmt.execute(['IT Park', 11.5]);

  insertBrtStmt.dispose();

  final insertStmt = db.prepare('''
    INSERT INTO routes (origin, destination, title, subtitle, path, duration, price, comparison, status, isFree)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''');

  // ========================================================================
  // 🚍 EDIT YOUR REAL ROUTES DOWN BELOW!
  // Format: [Origin, Destination, Title, Subtitle, Path, Duration, Price, Comparison, Status, isFree (1 for true, 0 for false)]
  // ========================================================================

  // Route 4: SM City Cebu <-> Airport
  insertStmt.execute([
    'SM City Cebu',
    'Airport',
    'MyBus Route 4',
    'SM City Cebu - Airport',
    'SM City Cebu → Parkmall → Airport',
    'Several stops',
    '₱50.00',
    'vs ₱300+ Taxi',
    'Every 30 mins (6AM-9PM)',
    0,
  ]);
  insertStmt.execute([
    'Airport',
    'SM City Cebu',
    'MyBus Route 4',
    'Airport - SM City Cebu',
    'Airport → Island Central → SM City Cebu',
    'Several stops',
    '₱50.00',
    'vs ₱300+ Taxi',
    'Every 30 mins (7AM-10PM)',
    0,
  ]);

  // Route 3: Anjo World <-> SM City Cebu via SRP
  insertStmt.execute([
    'Anjo World',
    'SM City Cebu',
    'MyBus Route 3',
    'Anjo World - SM Cebu via SRP',
    'Anjo World → Talisay → Il Corso → SM City Cebu',
    'Several stops',
    '₱50.00',
    'vs ₱250+ Grab',
    'Every 10-20 mins (5:20AM-9PM)',
    0,
  ]);
  insertStmt.execute([
    'SM City Cebu',
    'Anjo World',
    'MyBus Route 3',
    'SM Cebu - Anjo World via SRP',
    'SM City Cebu → SRP → Talisay → Anjo World',
    'Several stops',
    '₱50.00',
    'vs ₱250+ Grab',
    'Every 20 mins (5AM-10PM)',
    0,
  ]);

  // FREE RIDE: Fuente <-> SM Seaside
  insertStmt.execute([
    'Fuente',
    'SM Seaside',
    'FREE RIDE',
    'Fuente - SM Seaside (Pick-up only)',
    'BDO Fuente → N. Bacalso → SM Seaside',
    '4 stops',
    '₱0.00',
    'vs ₱150 Grab',
    'Every 30 mins (9AM-8PM)',
    1,
  ]);
  insertStmt.execute([
    'SM Seaside',
    'Fuente',
    'FREE RIDE',
    'SM Seaside - Fuente (Drop-off only)',
    'SM Seaside → N. Bacalso → BDO Fuente',
    '4 stops',
    '₱0.00',
    'vs ₱150 Grab',
    'Every 30 mins (11AM-10PM)',
    1,
  ]);

  // Route 1: J Mall <-> SM Seaside
  insertStmt.execute([
    'J Mall',
    'SM Seaside',
    'MyBus Route 1',
    'J Mall - SM Cebu - SM Seaside',
    'J Mall → SM City Cebu → SM Seaside',
    'Several stops',
    '₱30.00',
    '',
    'Every 20-30 mins (7:40AM-9PM)',
    0,
  ]);
  insertStmt.execute([
    'SM Seaside',
    'J Mall',
    'MyBus Route 1',
    'SM Seaside - SM Cebu - J Mall',
    'SM Seaside → SM City Cebu → J Mall',
    'Several stops',
    '₱30.00',
    '',
    'Every 20-30 mins (8:40AM-10PM)',
    0,
  ]);

  // Route 2: Anjo World <-> SM Seaside
  insertStmt.execute([
    'Anjo World',
    'SM Seaside',
    'MyBus Route 2',
    'Anjo World - SM Seaside via SRP',
    'Anjo World → Talisay → SM Seaside',
    'Several stops',
    '₱30.00',
    '',
    'Every 20 mins (6AM-9PM)',
    0,
  ]);
  insertStmt.execute([
    'SM Seaside',
    'Anjo World',
    'MyBus Route 2',
    'SM Seaside - Anjo World via SRP',
    'SM Seaside → Talisay → Anjo World',
    'Several stops',
    '₱30.00',
    '',
    'Every 20 mins (7AM-10PM)',
    0,
  ]);

  // Love Bus Libreng Sakay
  insertStmt.execute([
    'Talisay City',
    'Cebu City (SRP)',
    'LOVE BUS',
    'Libreng Sakay Program',
    'Anjo World → SM Seaside (SRP)',
    'Direct/Several stops',
    '₱0.00',
    'vs ₱150 Grab',
    '6-9 AM | 5-8 PM',
    1,
  ]);

  // ========================================================================

  insertStmt.dispose();
  db.dispose();

  print('Successfully generated routes.db with your updated data!');
}

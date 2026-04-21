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

  db.execute('''
    CREATE TABLE terminals (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      waitTime TEXT NOT NULL,
      routeCount TEXT NOT NULL,
      updatedTime TEXT NOT NULL,
      isFree INTEGER NOT NULL,
      accentColorHex TEXT NOT NULL
    )
  ''');

  db.execute('''
    CREATE TABLE schedules (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      providerBadge TEXT NOT NULL,
      routeName TEXT NOT NULL,
      routeDetails TEXT NOT NULL,
      priceLabel TEXT NOT NULL,
      frequencyLabel TEXT NOT NULL,
      isFree INTEGER NOT NULL,
      accentColorHex TEXT NOT NULL
    )
  ''');

  db.execute('''
    CREATE TABLE trips (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      route TEXT NOT NULL,
      timestamp TEXT NOT NULL,
      provider TEXT NOT NULL,
      savings TEXT NOT NULL,
      accentColorHex TEXT NOT NULL,
      providerColorHex TEXT NOT NULL
    )
  ''');

  db.execute('''
    CREATE TABLE buses (
      id TEXT PRIMARY KEY,
      route_id TEXT NOT NULL,
      last_known_stop TEXT NOT NULL,
      direction TEXT NOT NULL
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

  final insertTerminalStmt = db.prepare('''
    INSERT INTO terminals (name, description, waitTime, routeCount, updatedTime, isFree, accentColorHex)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  ''');

  insertTerminalStmt.execute(['IT Park', 'BRT anchor', '~3 min', '3 routes', '2 min ago', 1, 'FF2196F3']);
  insertTerminalStmt.execute(['SM Seaside', 'BRT + MyBus', '~7 min', '4 routes', '2 min ago', 1, 'FF64FFDA']);
  insertTerminalStmt.execute(['SM City', 'MyBus main hub', '~5 min', '5 routes', '2 min ago', 0, 'FF64FFDA']);
  insertTerminalStmt.execute(['Il Corso', 'BRT terminus', '~12 min', '1 route', '2 min ago', 1, 'FF2196F3']);
  insertTerminalStmt.execute(['SM JMall', 'Mandaue - MyBus', '~8 min', '2 routes', '2 min ago', 0, 'FF64FFDA']);
  insertTerminalStmt.execute(['Anjo World', 'Love Bus + MyBus', '~15 min', '3 routes', '2 min ago', 1, 'FFFF4081']);

  insertTerminalStmt.dispose();

  final insertScheduleStmt = db.prepare('''
    INSERT INTO schedules (providerBadge, routeName, routeDetails, priceLabel, frequencyLabel, isFree, accentColorHex)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  ''');

  insertScheduleStmt.execute(['BRT', 'IT Park ↔ Il Corso', '9 stops · ~35 min', 'FREE - Peak only', 'Continuous', 1, 'FF448AFF']);
  insertScheduleStmt.execute(['MyBus R1', 'JMall ↔ SM City ↔ SM Seaside', '12 stops · ~45 min', '₱30', '30 min (wkday) · 20 min (w... ', 0, 'FF64FFDA']);
  insertScheduleStmt.execute(['MyBus R2', 'Anjo World ↔ SM Seaside via SRP', '15 stops · ~40 min', '₱30', 'Every 20 min', 0, 'FF64FFDA']);
  insertScheduleStmt.execute(['MyBus R3', 'Anjo World ↔ SM City / Parkmall', '20 stops · ~60 min', '₱50', 'Every 5-20 min', 0, 'FF64FFDA']);
  insertScheduleStmt.execute(['MyBus R4', 'SM City ↔ Airport (MCIA)', '8 stops · ~35 min', '₱50', 'Every 30 min', 0, 'FF64FFDA']);

  insertScheduleStmt.dispose();

  final insertTripStmt = db.prepare('''
    INSERT INTO trips (route, timestamp, provider, savings, accentColorHex, providerColorHex)
    VALUES (?, ?, ?, ?, ?, ?)
  ''');

  insertTripStmt.execute(['IT Park → Il Corso', 'Today 8:30 AM', 'BRT', '₱150', 'FF00FF9D', 'FF00FF9D']);
  insertTripStmt.execute(['SM Seaside → SM JMall', 'Today 9:15 AM', 'MyBus', '₱80', 'FFE040FB', 'FFE040FB']);
  insertTripStmt.execute(['Il Corso → IT Park', 'Yesterday 6:00 PM', 'BRT', '₱150', 'FF00FF9D', 'FF00FF9D']);
  insertTripStmt.execute(['Anjo World → SM City', 'Yesterday 7:30 AM', 'MyBus', '₱120', 'FFE040FB', 'FFE040FB']);

  insertTripStmt.dispose();

  final insertBusStmt = db.prepare('''
    INSERT INTO buses (id, route_id, last_known_stop, direction)
    VALUES (?, ?, ?, ?)
  ''');

  insertBusStmt.execute(['BUS-101', 'BRT-1', 'Capitol', 'Southbound']);
  insertBusStmt.execute(['BUS-102', 'BRT-1', 'Fuente', 'Northbound']);
  insertBusStmt.execute(['BUS-201', 'MYBUS-R1', 'SM City', 'Southbound']);

  insertBusStmt.dispose();

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

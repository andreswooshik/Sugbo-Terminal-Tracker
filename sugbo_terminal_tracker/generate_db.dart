// tool/generate_db.dart
import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final assetsDir = Directory('assets');
  if (!assetsDir.existsSync()) {
    assetsDir.createSync(recursive: true);
  }

  final dbPath = 'assets/routes.db';
  if (File(dbPath).existsSync()) {
    File(dbPath).deleteSync();
  }

  print('🔄 Generating fresh database at: $dbPath');
  final db = sqlite3.open(dbPath);

  // ----------------------------------------------------------------------
  // CREATE TABLES
  // ----------------------------------------------------------------------
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
      isFree INTEGER NOT NULL,
      freeTimeStart TEXT,
      freeTimeEnd TEXT,
      routeType TEXT NOT NULL DEFAULT 'regular',
      scheduleWeekday TEXT,
      scheduleWeekend TEXT,
      frequency TEXT
    )
  ''');

  db.execute('''
    CREATE TABLE brt_stations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      station_name TEXT NOT NULL,
      km_marker REAL NOT NULL
    )
  ''');

  // ----------------------------------------------------------------------
  // BRT STATIONS (Corrected for Cebu BRT Route)
  // ----------------------------------------------------------------------
  final insertBrtStmt = db.prepare(
    'INSERT INTO brt_stations (station_name, km_marker) VALUES (?, ?)',
  );

  final brtData = [
    ['Il Corso', 0.0],
    ['SM Seaside', 1.2],
    ['Mambaling', 2.8],
    ['SIT/CIT', 3.5],
    ['V. Rama', 4.2],
    ['CSBT', 5.0],
    ['CNU', 5.8],
    ['Fuente', 6.5],
    ['Capitol', 7.2],
    ['Sacred Heart', 8.0],
    ['Ayala South', 8.7],
    ['Pag-IBIG (Ayala)', 9.3],
    ['Samar Loop', 10.0],
    ['Negros Road', 10.8],
    ['Luz', 11.5],
    ['IT Park', 13.0],
  ];

  for (var data in brtData) {
    insertBrtStmt.execute(data);
  }
  insertBrtStmt.dispose();

  // ----------------------------------------------------------------------
  // PREPARE ROUTE INSERT STATEMENT
  // ----------------------------------------------------------------------
  final insertStmt = db.prepare('''
    INSERT INTO routes (
      origin, destination, title, subtitle, path,
      duration, price, comparison, status, isFree,
      freeTimeStart, freeTimeEnd, routeType,
      scheduleWeekday, scheduleWeekend, frequency
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''');

  // Helper function to reduce boilerplate
  void addRoute({
    required String origin,
    required String destination,
    required String title,
    required String subtitle,
    required String path,
    required String duration,
    required String price,
    String comparison = 'Standard Fare',
    String status = 'Operational',
    int isFree = 0,
    String? freeTimeStart,
    String? freeTimeEnd,
    String routeType = 'regular',
    String? scheduleWeekday,
    String? scheduleWeekend,
    String? frequency,
  }) {
    insertStmt.execute([
      origin,
      destination,
      title,
      subtitle,
      path,
      duration,
      price,
      comparison,
      status,
      isFree,
      freeTimeStart,
      freeTimeEnd,
      routeType,
      scheduleWeekday,
      scheduleWeekend,
      frequency,
    ]);
  }

  // ======================================================================
  // MYBUS ROUTES (Updated with full schedules)
  // ======================================================================

  // ---- Route 1: J Mall – SM Seaside ----
  addRoute(
    origin: 'J Mall',
    destination: 'SM Seaside',
    title: 'MyBus Route 1',
    subtitle: 'J Mall – SM Seaside via Mandaue',
    path:
        'J Mall → Nissan → Happy Mart → Hi-way Seno → Tipolo Skywalk → 7/11 Subangdaku → SM City Cebu → Robinsons Galleria → Compania Maritima → SM Seaside',
    duration: '45-60 mins',
    price: '₱30.00',
    scheduleWeekday:
        '7:40,8:10,8:40,9:10,9:40,10:10,10:40,11:10,11:40,12:10,12:40,13:10,13:40,14:10,14:40,15:10,15:40,16:10,16:40,17:10,17:40,18:10,18:40,19:10,19:40,20:10,20:40,21:10', // every 30 mins from 7:40 to 21:10
    scheduleWeekend:
        '7:40,8:00,8:20,8:40,9:00,9:20,9:40,10:00,10:20,10:40,11:00,11:20,11:40,12:00,12:20,12:40,13:00,13:20,13:40,14:00,14:20,14:40,15:00,15:20,15:40,16:00,16:20,16:40,17:00,17:20,17:40,18:00,18:20,18:40,19:00,19:20,19:40,20:00,20:20,20:40,21:00',
    frequency: 'Weekday: 30 mins, Weekend: 20 mins',
  );

  addRoute(
    origin: 'SM Seaside',
    destination: 'J Mall',
    title: 'MyBus Route 1',
    subtitle: 'SM Seaside – J Mall via Mandaue',
    path:
        'SM Seaside → Compania Maritima → Robinsons Galleria → SM City Cebu → 7/11 Subangdaku → Tipolo Skywalk → Hi-way Seno → Happy Mart → Nissan → J Mall',
    duration: '45-60 mins',
    price: '₱30.00',
    scheduleWeekday:
        '8:40,9:10,9:40,10:10,10:40,11:10,11:40,12:10,12:40,13:10,13:40,14:10,14:40,15:10,15:40,16:10,16:40,17:10,17:40,18:10,18:40,19:10,19:40,20:10,20:40,21:10,21:40,22:10',
    scheduleWeekend:
        '8:40,9:00,9:20,9:40,10:00,10:20,10:40,11:00,11:20,11:40,12:00,12:20,12:40,13:00,13:20,13:40,14:00,14:20,14:40,15:00,15:20,15:40,16:00,16:20,16:40,17:00,17:20,17:40,18:00,18:20,18:40,19:00,19:20,19:40,20:00,20:20,20:40,21:00,21:20,21:40,22:00',
    frequency: 'Weekday: 30 mins, Weekend: 20 mins',
  );

  // ---- Route 2: Anjo World – SM Seaside (via SRP) ----
  addRoute(
    origin: 'Anjo World',
    destination: 'SM Seaside',
    title: 'MyBus Route 2',
    subtitle: 'Anjo World – SM Seaside via SRP',
    path:
        'Anjo World → Calajoan → Lipata → Linao → Talisay City Hall → San Isidro → Dawis → Carmen → Cansojong → Rabaya → Laray → Filinvest - IL Corso → SRP Sugbo Grounds → SM Seaside',
    duration: '40-50 mins',
    price: '₱30.00',
    scheduleWeekday:
        '6:00,6:20,6:40,7:00,7:20,7:40,8:00,8:20,8:40,9:00,9:20,9:40,10:00,10:20,10:40,11:00,11:20,11:40,12:00,12:20,12:40,13:00,13:20,13:40,14:00,14:20,14:40,15:00,15:20,15:40,16:00,16:20,16:40,17:00,17:20,17:40,18:00,18:20,18:40,19:00,19:20,19:40,20:00,20:20,20:40,21:00',
    scheduleWeekend:
        '6:00,6:20,6:40,7:00,7:20,7:40,8:00,8:20,8:40,9:00,9:20,9:40,10:00,10:20,10:40,11:00,11:20,11:40,12:00,12:20,12:40,13:00,13:20,13:40,14:00,14:20,14:40,15:00,15:20,15:40,16:00,16:20,16:40,17:00,17:20,17:40,18:00,18:20,18:40,19:00,19:20,19:40,20:00,20:20,20:40,21:00',
    frequency: 'Every 20 mins',
  );

  addRoute(
    origin: 'SM Seaside',
    destination: 'Anjo World',
    title: 'MyBus Route 2',
    subtitle: 'SM Seaside – Anjo World via SRP',
    path:
        'SM Seaside → SRP Sugbo Grounds → Filinvest - IL Corso → Laray → Rabaya → Cansojong → Carmen → Dawis → San Isidro → Talisay City Hall → Linao → Lipata → Calajoan → Anjo World',
    duration: '40-50 mins',
    price: '₱30.00',
    scheduleWeekday:
        '7:00,7:20,7:40,8:00,8:20,8:40,9:00,9:20,9:40,10:00,10:20,10:40,11:00,11:20,11:40,12:00,12:20,12:40,13:00,13:20,13:40,14:00,14:20,14:40,15:00,15:20,15:40,16:00,16:20,16:40,17:00,17:20,17:40,18:00,18:20,18:40,19:00,19:20,19:40,20:00,20:20,20:40,21:00,21:20,21:40,22:00',
    scheduleWeekend:
        '7:00,7:20,7:40,8:00,8:20,8:40,9:00,9:20,9:40,10:00,10:20,10:40,11:00,11:20,11:40,12:00,12:20,12:40,13:00,13:20,13:40,14:00,14:20,14:40,15:00,15:20,15:40,16:00,16:20,16:40,17:00,17:20,17:40,18:00,18:20,18:40,19:00,19:20,19:40,20:00,20:20,20:40,21:00,21:20,21:40,22:00',
    frequency: 'Every 20 mins',
  );

  // ---- Route 3: Anjo World – SM Cebu / Parkmall (via SRP) ----
  addRoute(
    origin: 'Anjo World',
    destination: 'Parkmall',
    title: 'MyBus Route 3',
    subtitle: 'Anjo World – Parkmall via SRP & SM Cebu',
    path:
        'Anjo World → Calajoan → Lipata → Linao → Talisay City Hall → San Isidro → Dawis → Carmen → Cansojong → Rabaya → Laray → Filinvest - IL Corso → SRP Sugbo Grounds → Malacañang sa Sugbo → Robinsons Galleria → SM City Cebu → UC Med → Chong Hua Hospital → Harrison Park → Parkmall',
    duration: '60-75 mins',
    price: '₱50.00',
    scheduleWeekday:
        '5:20,5:40,6:00,6:20,6:40,7:00,7:20,7:40,8:00,8:20,8:40,9:00,9:20,9:40,10:00,10:20,10:40,11:00,11:20,11:40,12:00,12:20,12:40,13:00,13:20,13:40,14:00,14:20,14:40,15:00,15:20,15:40,16:00,16:20,16:40,17:00,17:20,17:40,18:00,18:20,18:40,19:00,19:20,19:40,20:00,20:20,20:40,21:00',
    scheduleWeekend:
        '5:20,5:40,6:00,6:20,6:40,7:00,7:20,7:40,8:00,8:20,8:40,9:00,9:20,9:40,10:00,10:20,10:40,11:00,11:20,11:40,12:00,12:20,12:40,13:00,13:20,13:40,14:00,14:20,14:40,15:00,15:20,15:40,16:00,16:20,16:40,17:00,17:20,17:40,18:00,18:20,18:40,19:00,19:20,19:40,20:00,20:20,20:40,21:00',
    frequency: 'Every 5-20 mins (peak/off-peak)',
  );

  addRoute(
    origin: 'SM City Cebu',
    destination: 'Anjo World',
    title: 'MyBus Route 3',
    subtitle: 'SM City Cebu – Anjo World via SRP',
    path:
        'SM City Cebu → Robinsons Galleria → Malacañang sa Sugbo → SRP Sugbo Grounds → Filinvest - IL Corso → Laray → Rabaya → Cansojong → Carmen → Dawis → San Isidro → Talisay City Hall → Linao → Lipata → Calajoan → Anjo World',
    duration: '50-60 mins',
    price: '₱50.00',
    scheduleWeekday:
        '5:00,5:20,5:40,6:00,6:20,6:40,7:00,7:20,7:40,8:00,8:20,8:40,9:00,9:20,9:40,10:00,10:20,10:40,11:00,11:20,11:40,12:00,12:20,12:40,13:00,13:20,13:40,14:00,14:20,14:40,15:00,15:20,15:40,16:00,16:20,16:40,17:00,17:20,17:40,18:00,18:20,18:40,19:00,19:20,19:40,20:00,20:20,20:40,21:00,21:20,21:40,22:00',
    scheduleWeekend:
        '5:00,5:20,5:40,6:00,6:20,6:40,7:00,7:20,7:40,8:00,8:20,8:40,9:00,9:20,9:40,10:00,10:20,10:40,11:00,11:20,11:40,12:00,12:20,12:40,13:00,13:20,13:40,14:00,14:20,14:40,15:00,15:20,15:40,16:00,16:20,16:40,17:00,17:20,17:40,18:00,18:20,18:40,19:00,19:20,19:40,20:00,20:20,20:40,21:00,21:20,21:40,22:00',
    frequency: 'Every 20 mins',
  );

  // ---- Route 4: SM City Cebu – Airport ----
  addRoute(
    origin: 'SM City Cebu',
    destination: 'Mactan-Cebu International Airport',
    title: 'MyBus Route 4',
    subtitle: 'SM City Cebu – Airport via Mandaue',
    path:
        'SM City Cebu → Mantawi Int\'l Drive (UC Med/Chong Hua) → Parkmall → Plaridel St. → Island Central Mall → Airport',
    duration: '45-60 mins',
    price: '₱50.00',
    scheduleWeekday:
        '6:00,6:30,7:00,7:30,8:00,8:30,9:00,9:30,10:00,10:30,11:00,11:30,12:00,12:30,13:00,13:30,14:00,14:30,15:00,15:30,16:00,16:30,17:00,17:30,18:00,18:30,19:00,19:30,20:00,20:30,21:00',
    scheduleWeekend:
        '6:00,6:30,7:00,7:30,8:00,8:30,9:00,9:30,10:00,10:30,11:00,11:30,12:00,12:30,13:00,13:30,14:00,14:30,15:00,15:30,16:00,16:30,17:00,17:30,18:00,18:30,19:00,19:30,20:00,20:30,21:00',
    frequency: 'Every 30 mins',
  );

  addRoute(
    origin: 'Mactan-Cebu International Airport',
    destination: 'SM City Cebu',
    title: 'MyBus Route 4',
    subtitle: 'Airport – SM City Cebu via Mandaue',
    path:
        'Airport → Island Central Mall → Plaridel St. → Parkmall → Mantawi Int\'l Drive (UC Med/Chong Hua) → SM City Cebu',
    duration: '45-60 mins',
    price: '₱50.00',
    scheduleWeekday:
        '7:00,7:30,8:00,8:30,9:00,9:30,10:00,10:30,11:00,11:30,12:00,12:30,13:00,13:30,14:00,14:30,15:00,15:30,16:00,16:30,17:00,17:30,18:00,18:30,19:00,19:30,20:00,20:30,21:00,21:30,22:00',
    scheduleWeekend:
        '7:00,7:30,8:00,8:30,9:00,9:30,10:00,10:30,11:00,11:30,12:00,12:30,13:00,13:30,14:00,14:30,15:00,15:30,16:00,16:30,17:00,17:30,18:00,18:30,19:00,19:30,20:00,20:30,21:00,21:30,22:00',
    frequency: 'Every 30 mins',
  );

  // ---- MyBus Free Ride: Fuente – SM Seaside ----
  addRoute(
    origin: 'Fuente',
    destination: 'SM Seaside',
    title: 'MyBus Free Ride',
    subtitle: 'Fuente → SM Seaside (Pick-up only)',
    path:
        'BDO Fuente → V. Rama → N. Bacalso Highway (Dr. Uy) → Cebu Home Builders → SM Seaside',
    duration: '30-40 mins',
    price: 'FREE',
    comparison: 'Libreng Sakay Program',
    status: 'Pick-up only',
    isFree: 1,
    freeTimeStart: '09:00',
    freeTimeEnd: '20:00',
    routeType: 'libreng_sakay',
    scheduleWeekday:
        '9:00,9:30,10:00,10:30,11:00,11:30,12:00,12:30,13:00,13:30,14:00,14:30,15:00,15:30,16:00,16:30,17:00,17:30,18:00,18:30,19:00,19:30,20:00',
    scheduleWeekend:
        '9:00,9:30,10:00,10:30,11:00,11:30,12:00,12:30,13:00,13:30,14:00,14:30,15:00,15:30,16:00,16:30,17:00,17:30,18:00,18:30,19:00,19:30,20:00',
    frequency: 'Every 30 mins',
  );

  addRoute(
    origin: 'SM Seaside',
    destination: 'Fuente',
    title: 'MyBus Free Ride',
    subtitle: 'SM Seaside → Fuente (Drop-off only)',
    path:
        'SM Seaside → Cebu Home Builders → N. Bacalso Highway (Dr. Uy) → V. Rama → BDO Fuente',
    duration: '30-40 mins',
    price: 'FREE',
    comparison: 'Libreng Sakay Program',
    status: 'Drop-off only',
    isFree: 1,
    freeTimeStart: '11:00',
    freeTimeEnd: '22:00',
    routeType: 'libreng_sakay',
    scheduleWeekday:
        '11:00,11:30,12:00,12:30,13:00,13:30,14:00,14:30,15:00,15:30,16:00,16:30,17:00,17:30,18:00,18:30,19:00,19:30,20:00,20:30,21:00,21:30,22:00',
    scheduleWeekend:
        '11:00,11:30,12:00,12:30,13:00,13:30,14:00,14:30,15:00,15:30,16:00,16:30,17:00,17:30,18:00,18:30,19:00,19:30,20:00,20:30,21:00,21:30,22:00',
    frequency: 'Every 30 mins',
  );

  // ---- Love Bus "Libreng Sakay" Program ----
  // Talisay/Anjo World – Cebu City (SRP) during peak hours 6-9am & 5-8pm
  addRoute(
    origin: 'Anjo World',
    destination: 'SM City Cebu',
    title: 'Love Bus (Libreng Sakay)',
    subtitle: 'Anjo World → SM City Cebu via SRP',
    path: 'Anjo World → Talisay → SRP → SM City Cebu',
    duration: '50-60 mins',
    price: 'FREE',
    comparison: 'Save ₱50.00!',
    status: 'Peak hours only',
    isFree: 1,
    freeTimeStart: '06:00',
    freeTimeEnd: '09:00',
    routeType: 'libreng_sakay',
    scheduleWeekday: '6:00,6:30,7:00,7:30,8:00,8:30',
    scheduleWeekend: '6:00,6:30,7:00,7:30,8:00,8:30',
    frequency: 'Every 30 mins (morning peak)',
  );

  // Add evening window as separate record (or combine with freeTimeStart/End covering both windows?)
  // Since freeTimeStart/End are single strings, we'll add two entries for morning and evening
  addRoute(
    origin: 'Anjo World',
    destination: 'SM City Cebu',
    title: 'Love Bus (Libreng Sakay)',
    subtitle: 'Anjo World → SM City Cebu via SRP',
    path: 'Anjo World → Talisay → SRP → SM City Cebu',
    duration: '50-60 mins',
    price: 'FREE',
    comparison: 'Save ₱50.00!',
    status: 'Peak hours only',
    isFree: 1,
    freeTimeStart: '17:00',
    freeTimeEnd: '20:00',
    routeType: 'libreng_sakay',
    scheduleWeekday: '17:00,17:30,18:00,18:30,19:00,19:30',
    scheduleWeekend: '17:00,17:30,18:00,18:30,19:00,19:30',
    frequency: 'Every 30 mins (evening peak)',
  );

  addRoute(
    origin: 'SM City Cebu',
    destination: 'Anjo World',
    title: 'Love Bus (Libreng Sakay)',
    subtitle: 'SM City Cebu → Anjo World via SRP',
    path: 'SM City Cebu → SRP → Talisay → Anjo World',
    duration: '50-60 mins',
    price: 'FREE',
    comparison: 'Save ₱50.00!',
    status: 'Peak hours only',
    isFree: 1,
    freeTimeStart: '06:00',
    freeTimeEnd: '09:00',
    routeType: 'libreng_sakay',
    scheduleWeekday: '6:00,6:30,7:00,7:30,8:00,8:30',
    scheduleWeekend: '6:00,6:30,7:00,7:30,8:00,8:30',
    frequency: 'Every 30 mins (morning peak)',
  );

  addRoute(
    origin: 'SM City Cebu',
    destination: 'Anjo World',
    title: 'Love Bus (Libreng Sakay)',
    subtitle: 'SM City Cebu → Anjo World via SRP',
    path: 'SM City Cebu → SRP → Talisay → Anjo World',
    duration: '50-60 mins',
    price: 'FREE',
    comparison: 'Save ₱50.00!',
    status: 'Peak hours only',
    isFree: 1,
    freeTimeStart: '17:00',
    freeTimeEnd: '20:00',
    routeType: 'libreng_sakay',
    scheduleWeekday: '17:00,17:30,18:00,18:30,19:00,19:30',
    scheduleWeekend: '17:00,17:30,18:00,18:30,19:00,19:30',
    frequency: 'Every 30 mins (evening peak)',
  );

  insertStmt.dispose();
  db.dispose();

  print('✅ Database generated successfully with all MyBus routes!');
  print('📁 Location: ${File(dbPath).absolute.path}');
  print('👉 Copy this file to your Flutter project\'s assets/ folder.');
}

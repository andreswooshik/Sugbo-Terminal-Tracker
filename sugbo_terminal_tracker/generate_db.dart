import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  // Initialize FFI for SQLite
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  await generateTerminalsDb();
  await generateSchedulesDb();
  await generateSavingsDb();
  
  print('All databases generated successfully!');
}

Future<void> generateTerminalsDb() async {
  final dbPath = 'assets/terminals.db';
  File(dbPath).deleteSync();
  
  final db = await openDatabase(dbPath);
  
  await db.execute('''
    CREATE TABLE terminals (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      wait_time TEXT NOT NULL,
      route_count TEXT NOT NULL,
      last_updated TEXT NOT NULL,
      is_free INTEGER NOT NULL DEFAULT 0,
      accent_color TEXT NOT NULL
    )
  ''');
  
  await db.insert('terminals', {
    'name': 'IT Park',
    'description': 'BRT anchor',
    'wait_time': '~3 min',
    'route_count': '3 routes',
    'last_updated': '2 min ago',
    'is_free': 1,
    'accent_color': '#0000FF',
  });
  
  await db.insert('terminals', {
    'name': 'SM Seaside',
    'description': 'BRT + MyBus',
    'wait_time': '~7 min',
    'route_count': '4 routes',
    'last_updated': '2 min ago',
    'is_free': 1,
    'accent_color': '#00FF00',
  });
  
  await db.insert('terminals', {
    'name': 'SM City',
    'description': 'MyBus main hub',
    'wait_time': '~5 min',
    'route_count': '5 routes',
    'last_updated': '2 min ago',
    'is_free': 0,
    'accent_color': '#00FF00',
  });
  
  await db.insert('terminals', {
    'name': 'Il Corso',
    'description': 'BRT terminus',
    'wait_time': '~12 min',
    'route_count': '1 route',
    'last_updated': '2 min ago',
    'is_free': 1,
    'accent_color': '#0000FF',
  });
  
  await db.insert('terminals', {
    'name': 'SM JMall',
    'description': 'Mandaue - MyBus',
    'wait_time': '~8 min',
    'route_count': '2 routes',
    'last_updated': '2 min ago',
    'is_free': 0,
    'accent_color': '#00FF00',
  });
  
  await db.insert('terminals', {
    'name': 'Anjo World',
    'description': 'Love Bus + MyBus',
    'wait_time': '~15 min',
    'route_count': '3 routes',
    'last_updated': '2 min ago',
    'is_free': 1,
    'accent_color': '#FF00FF',
  });
  
  await db.close();
  print('Generated terminals.db');
}

Future<void> generateSchedulesDb() async {
  final dbPath = 'assets/schedules.db';
  File(dbPath).deleteSync();
  
  final db = await openDatabase(dbPath);
  
  await db.execute('''
    CREATE TABLE schedules (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      provider_badge TEXT NOT NULL,
      route_name TEXT NOT NULL,
      route_details TEXT NOT NULL,
      price_label TEXT NOT NULL,
      frequency_label TEXT NOT NULL,
      accent_color TEXT NOT NULL,
      is_free INTEGER NOT NULL DEFAULT 0
    )
  ''');
  
  await db.insert('schedules', {
    'provider_badge': 'BRT',
    'route_name': 'IT Park ↔ Il Corso',
    'route_details': '9 stops · ~35 min',
    'price_label': 'FREE - Peak only',
    'frequency_label': 'Continuous',
    'accent_color': '#1E90FF',
    'is_free': 1,
  });
  
  await db.insert('schedules', {
    'provider_badge': 'MyBus R1',
    'route_name': 'JMall ↔ SM City ↔ SM Seaside',
    'route_details': '12 stops · ~45 min',
    'price_label': '₱30',
    'frequency_label': '30 min (wkday) · 20 min (wknd)',
    'accent_color': '#00FF00',
    'is_free': 0,
  });
  
  await db.insert('schedules', {
    'provider_badge': 'MyBus R2',
    'route_name': 'Anjo World ↔ SM Seaside via SRP',
    'route_details': '15 stops · ~40 min',
    'price_label': '₱30',
    'frequency_label': 'Every 20 min',
    'accent_color': '#00FF00',
    'is_free': 0,
  });
  
  await db.insert('schedules', {
    'provider_badge': 'MyBus R3',
    'route_name': 'Anjo World ↔ SM City / Parkmall',
    'route_details': '20 stops · ~60 min',
    'price_label': '₱50',
    'frequency_label': 'Every 5-20 min',
    'accent_color': '#00FF00',
    'is_free': 0,
  });
  
  await db.insert('schedules', {
    'provider_badge': 'MyBus R4',
    'route_name': 'SM City ↔ Airport (MCIA)',
    'route_details': '8 stops · ~35 min',
    'price_label': '₱50',
    'frequency_label': 'Every 30 min',
    'accent_color': '#00FF00',
    'is_free': 0,
  });
  
  await db.insert('schedules', {
    'provider_badge': 'Love Bus',
    'route_name': 'Anjo World / Talisay → Cebu SRP',
    'route_details': 'SRP corridor',
    'price_label': 'FREE - Peak only',
    'frequency_label': '6-9 AM and 5-8 PM only',
    'accent_color': '#FF1493',
    'is_free': 1,
  });
  
  await db.close();
  print('Generated schedules.db');
}

Future<void> generateSavingsDb() async {
  final dbPath = 'assets/savings.db';
  File(dbPath).deleteSync();
  
  final db = await openDatabase(dbPath);
  
  await db.execute('''
    CREATE TABLE trips (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      route TEXT NOT NULL,
      timestamp TEXT NOT NULL,
      provider TEXT NOT NULL,
      savings_amount REAL NOT NULL,
      accent_color TEXT NOT NULL,
      provider_color TEXT NOT NULL
    )
  ''');
  
  await db.insert('trips', {
    'route': 'IT Park → Il Corso',
    'timestamp': 'Today 8:30 AM',
    'provider': 'BRT',
    'savings_amount': 150.0,
    'accent_color': '#00FF9D',
    'provider_color': '#00FF9D',
  });
  
  await db.insert('trips', {
    'route': 'SM Seaside → SM JMall',
    'timestamp': 'Today 9:15 AM',
    'provider': 'MyBus',
    'savings_amount': 80.0,
    'accent_color': '#E040FB',
    'provider_color': '#E040FB',
  });
  
  await db.insert('trips', {
    'route': 'Il Corso → IT Park',
    'timestamp': 'Yesterday 6:00 PM',
    'provider': 'BRT',
    'savings_amount': 150.0,
    'accent_color': '#00FF9D',
    'provider_color': '#00FF9D',
  });
  
  await db.insert('trips', {
    'route': 'Anjo World → SM City',
    'timestamp': 'Yesterday 7:30 AM',
    'provider': 'MyBus',
    'savings_amount': 120.0,
    'accent_color': '#E040FB',
    'provider_color': '#E040FB',
  });
  
  await db.close();
  print('Generated savings.db');
}

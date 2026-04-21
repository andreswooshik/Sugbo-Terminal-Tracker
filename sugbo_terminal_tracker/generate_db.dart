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

  final insertStmt = db.prepare('''
    INSERT INTO routes (origin, destination, title, subtitle, path, duration, price, comparison, status, isFree)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''');

  // ========================================================================
  // 🚍 EDIT YOUR REAL ROUTES DOWN BELOW!
  // Format: [Origin, Destination, Title, Subtitle, Path, Duration, Price, Comparison, Status, isFree (1 for true, 0 for false)]
  // ========================================================================

  // Routes from IT Park to SM City Cebu
  insertStmt.execute([
    'IT Park', 'SM City Cebu', 'LIBRENG SAKAY', 
    'Cebu City Libreng Sakay - 6 AM to 9 AM | 4 PM to 7 PM', 
    'IT Park → Ayala → SM City Cebu', '2 stops · ~20-25 min', 
    '₱0.00', 'vs ₱150 Grab', 'Next bus: ~5 min', 1
  ]);

  insertStmt.execute([
    'IT Park', 'SM City Cebu', 'BEEP JEEP (IT Park - SM)', 
    'Modern Jeepney Route 04L', 
    'IT Park Terminal → Mabolo → SM City Cebu', 'Several stops · ~30 min', 
    '₱15.00', '', 'Every ~10 min', 0
  ]);

  // Routes from IT Park to Il Corso
  insertStmt.execute([
    'IT Park', 'Il Corso', 'LIBRENG SAKAY', 
    'BRT Libreng Sakay - 6:00 AM to 9:00 AM | 4:00 PM to 7:00 PM', 
    'IT Park → Ayala → Fuente → Seaside → Il Corso', '9 stops · ~35-40 min', 
    '₱0.00', 'vs ₱150-200 Grab', 'Next bus: ~10 min', 1
  ]);

  insertStmt.execute([
    'IT Park', 'Il Corso', 'REGULAR ROUTE', 
    'BRT Regular Bus - 9:00 AM to 4:00 PM', 
    'IT Park → Several stops → Il Corso', '9 stops · ~35-40 min', 
    '₱35.00', '', 'Every ~15 min during day', 0
  ]);

  // ADD MORE ROUTES HERE...
  // insertStmt.execute(['Origin', 'Destination', 'Title', 'Subtitle', 'Path', 'Duration', 'Price', 'Comparison', 'Status', 0]);

  // ========================================================================

  insertStmt.dispose();
  db.dispose();

  print('Successfully generated routes.db with your updated data!');
}

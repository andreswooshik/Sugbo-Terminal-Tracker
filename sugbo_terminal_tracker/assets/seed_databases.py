import sqlite3
import os

def create_terminals_db():
    db_path = 'assets/terminals.db'
    if os.path.exists(db_path):
        os.remove(db_path)
    
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    cursor.execute('''
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
    ''')
    
    terminals = [
        ('IT Park', 'BRT anchor', '~3 min', '3 routes', '2 min ago', 1, '#0000FF'),
        ('SM Seaside', 'BRT + MyBus', '~7 min', '4 routes', '2 min ago', 1, '#00FF00'),
        ('SM City', 'MyBus main hub', '~5 min', '5 routes', '2 min ago', 0, '#00FF00'),
        ('Il Corso', 'BRT terminus', '~12 min', '1 route', '2 min ago', 1, '#0000FF'),
        ('SM JMall', 'Mandaue - MyBus', '~8 min', '2 routes', '2 min ago', 0, '#00FF00'),
        ('Anjo World', 'Love Bus + MyBus', '~15 min', '3 routes', '2 min ago', 1, '#FF00FF'),
    ]
    
    cursor.executemany('''
        INSERT INTO terminals (name, description, wait_time, route_count, last_updated, is_free, accent_color)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    ''', terminals)
    
    conn.commit()
    conn.close()
    print('Created terminals.db')

def create_schedules_db():
    db_path = 'assets/schedules.db'
    if os.path.exists(db_path):
        os.remove(db_path)
    
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    cursor.execute('''
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
    ''')
    
    schedules = [
        ('BRT', 'IT Park ↔ Il Corso', '9 stops · ~35 min', 'FREE - Peak only', 'Continuous', '#1E90FF', 1),
        ('MyBus R1', 'JMall ↔ SM City ↔ SM Seaside', '12 stops · ~45 min', '₱30', '30 min (wkday) · 20 min (wknd)', '#00FF00', 0),
        ('MyBus R2', 'Anjo World ↔ SM Seaside via SRP', '15 stops · ~40 min', '₱30', 'Every 20 min', '#00FF00', 0),
        ('MyBus R3', 'Anjo World ↔ SM City / Parkmall', '20 stops · ~60 min', '₱50', 'Every 5-20 min', '#00FF00', 0),
        ('MyBus R4', 'SM City ↔ Airport (MCIA)', '8 stops · ~35 min', '₱50', 'Every 30 min', '#00FF00', 0),
        ('Love Bus', 'Anjo World / Talisay → Cebu SRP', 'SRP corridor', 'FREE - Peak only', '6-9 AM and 5-8 PM only', '#FF1493', 1),
    ]
    
    cursor.executemany('''
        INSERT INTO schedules (provider_badge, route_name, route_details, price_label, frequency_label, accent_color, is_free)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    ''', schedules)
    
    conn.commit()
    conn.close()
    print('Created schedules.db')

def create_savings_db():
    db_path = 'assets/savings.db'
    if os.path.exists(db_path):
        os.remove(db_path)
    
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    cursor.execute('''
        CREATE TABLE trips (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            route TEXT NOT NULL,
            timestamp TEXT NOT NULL,
            provider TEXT NOT NULL,
            savings_amount REAL NOT NULL,
            accent_color TEXT NOT NULL,
            provider_color TEXT NOT NULL
        )
    ''')
    
    trips = [
        ('IT Park → Il Corso', 'Today 8:30 AM', 'BRT', 150.0, '#00FF9D', '#00FF9D'),
        ('SM Seaside → SM JMall', 'Today 9:15 AM', 'MyBus', 80.0, '#E040FB', '#E040FB'),
        ('Il Corso → IT Park', 'Yesterday 6:00 PM', 'BRT', 150.0, '#00FF9D', '#00FF9D'),
        ('Anjo World → SM City', 'Yesterday 7:30 AM', 'MyBus', 120.0, '#E040FB', '#E040FB'),
    ]
    
    cursor.executemany('''
        INSERT INTO trips (route, timestamp, provider, savings_amount, accent_color, provider_color)
        VALUES (?, ?, ?, ?, ?, ?)
    ''', trips)
    
    conn.commit()
    conn.close()
    print('Created savings.db')

if __name__ == '__main__':
    create_terminals_db()
    create_schedules_db()
    create_savings_db()
    print('All databases created successfully!')

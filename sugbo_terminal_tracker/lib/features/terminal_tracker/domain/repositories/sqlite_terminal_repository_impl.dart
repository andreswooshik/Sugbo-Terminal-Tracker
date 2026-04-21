import 'dart:async';
import '../../../core/data/database_service.dart';
import '../entities/live_bus.dart';
import '../entities/terminal.dart';
import 'terminal_repository.dart';

class SqliteTerminalRepositoryImpl implements TerminalRepository {
  final DatabaseService _databaseService;
  final StreamController<Result<List<Terminal>, Exception>> _terminalController =
      StreamController<Result<List<Terminal>, Exception>>.broadcast();
  final StreamController<Result<List<LiveBus>, Exception>> _busController =
      StreamController<Result<List<LiveBus>, Exception>>.broadcast();

  SqliteTerminalRepositoryImpl({required DatabaseService databaseService})
      : _databaseService = databaseService {
    // Initial fetch
    _fetchTerminals();
    _fetchBuses();
  }

  Future<void> _fetchTerminals() async {
    try {
      final db = await _databaseService.database;
      final List<Map<String, dynamic>> maps = await db.query('terminals');
      final terminals = maps.map((map) {
        return Terminal(
          id: map['id'].toString(),
          name: map['name'],
          operator: map['description'],
          waitTime: int.tryParse(map['waitTime'].replaceAll(RegExp(r'[^0-9]'), '')),
          routesAvailable: int.tryParse(map['routeCount'].replaceAll(RegExp(r'[^0-9]'), '')),
          lastUpdated: DateTime.now(), // Simulated
        );
      }).toList();
      _terminalController.add(Success(terminals));
    } catch (e) {
      _terminalController.add(Failure(Exception(e.toString())));
    }
  }

  Future<void> _fetchBuses() async {
    try {
      final db = await _databaseService.database;
      final List<Map<String, dynamic>> maps = await db.query('buses');
      final buses = maps.map((map) => LiveBus.fromJson(map)).toList();
      _busController.add(Success(buses));
    } catch (e) {
      _busController.add(Failure(Exception(e.toString())));
    }
  }

  @override
  Stream<Result<List<Terminal>, Exception>> getTerminalsStream() {
    return _terminalController.stream;
  }

  @override
  Stream<Result<List<LiveBus>, Exception>> getLiveBusesStream() {
    return _busController.stream;
  }

  @override
  Future<Result<void, Exception>> reportWaitTime(String terminalId) async {
    try {
      final db = await _databaseService.database;
      // In a real app, we'd update the DB. For now, we simulate success.
      // Let's actually increment the waitTime in the DB for demonstration.
      final List<Map<String, dynamic>> current = await db.query(
        'terminals',
        where: 'id = ?',
        whereArgs: [terminalId],
      );
      if (current.isNotEmpty) {
        String waitStr = current.first['waitTime'];
        int waitTime = int.parse(waitStr.replaceAll(RegExp(r'[^0-9]'), ''));
        await db.update(
          'terminals',
          {'waitTime': '~${waitTime + 1} min'},
          where: 'id = ?',
          whereArgs: [terminalId],
        );
        _fetchTerminals(); // Refresh stream
      }
      return const Success(null);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  void dispose() {
    _terminalController.close();
    _busController.close();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/data/database_service.dart';
import '../models/terminal_wait_model.dart';

final terminalsRepositoryProvider = Provider<TerminalsRepository>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return TerminalsRepository(dbService);
});

final terminalsListProvider = FutureProvider<List<TerminalWaitModel>>((ref) {
  final repository = ref.watch(terminalsRepositoryProvider);
  return repository.getTerminals();
});

class TerminalsRepository {
  final DatabaseService _dbService;

  TerminalsRepository(this._dbService);

  Future<List<TerminalWaitModel>> getTerminals() async {
    final db = await _dbService.database;
    final List<Map<String, dynamic>> maps = await db.query('terminals');
    return maps.map((map) => TerminalWaitModel.fromMap(map)).toList();
  }
}

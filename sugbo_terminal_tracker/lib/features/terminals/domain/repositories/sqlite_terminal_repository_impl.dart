import '../../data/terminal_database_helper.dart';
import '../models/terminal_wait_model.dart';
import 'terminal_repository.dart';

class SqliteTerminalRepositoryImpl implements TerminalRepository {
  final TerminalDatabaseHelper _dbHelper;

  SqliteTerminalRepositoryImpl({TerminalDatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? TerminalDatabaseHelper.instance;

  @override
  Future<List<TerminalWaitModel>> getAllTerminals() async {
    return await _dbHelper.getAllTerminals();
  }

  @override
  Future<TerminalWaitModel?> getTerminalByName(String name) async {
    return await _dbHelper.getTerminalByName(name);
  }

  @override
  Future<void> updateWaitTime(String terminalName, String waitTime) async {
    return await _dbHelper.updateWaitTime(terminalName, waitTime);
  }
}

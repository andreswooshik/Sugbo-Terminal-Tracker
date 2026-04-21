import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/terminal_database_helper.dart';
import '../repositories/terminal_repository.dart';
import '../repositories/sqlite_terminal_repository_impl.dart';
import '../../models/terminal_wait_model.dart';

// Provide the Database Helper
final terminalDatabaseHelperProvider = Provider<TerminalDatabaseHelper>((ref) {
  return TerminalDatabaseHelper.instance;
});

// Provide the Repository using SQLite
final terminalRepositoryProvider = Provider<TerminalRepository>((ref) {
  final dbHelper = ref.watch(terminalDatabaseHelperProvider);
  return SqliteTerminalRepositoryImpl(dbHelper: dbHelper);
});

// Provide a stream of terminals from SQLite
final terminalsStreamProvider = StreamProvider.autoDispose<List<TerminalWaitModel>>((ref) async* {
  final repository = ref.watch(terminalRepositoryProvider);
  
  try {
    final terminals = await repository.getAllTerminals();
    yield terminals;
  } catch (e) {
    // Return empty list on error
    yield [];
  }
});

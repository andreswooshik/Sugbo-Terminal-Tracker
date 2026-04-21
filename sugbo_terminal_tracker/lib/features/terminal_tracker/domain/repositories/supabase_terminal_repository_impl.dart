import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/live_bus.dart';
import '../../domain/entities/terminal.dart';
import '../../domain/repositories/terminal_repository.dart';

// This is the CONCRETE implementation. It knows how to talk to Supabase.
class SupabaseTerminalRepositoryImpl implements TerminalRepository {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Stream<List<Terminal>> getTerminalsStream() {
    // Listen to all changes on the 'terminals' table
    return _client.from('terminals').stream(primaryKey: ['id']).map((list) {
      // Convert the list of JSON maps to a list of Terminal objects
      return list.map((json) => Terminal.fromJson(json)).toList();
    });
  }

  @override
  Stream<List<LiveBus>> getLiveBusesStream() {
    // Listen to all changes on the 'buses' table
    return _client.from('buses').stream(primaryKey: ['id']).map((list) {
      return list.map((json) => LiveBus.fromJson(json)).toList();
    });
  }

  @override
  Future<void> reportWaitTime(String terminalId) async {
    // Update the 'last_updated' timestamp for a specific terminal
    await _client.from('terminals').update({
      'last_updated': DateTime.now().toIso8601String(),
    }).eq('id', terminalId);
  }
}
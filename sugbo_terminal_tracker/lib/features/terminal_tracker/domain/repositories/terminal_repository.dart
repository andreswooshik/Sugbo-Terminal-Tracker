import '../entities/live_bus.dart';
import '../entities/terminal.dart';

// This is the contract our UI will use.
// It doesn't know or care about Supabase.
abstract class TerminalRepository {
  // Get a stream of live updates for all terminals
  Stream<List<Terminal>> getTerminalsStream();

  // Get a stream of live updates for all buses
  Stream<List<LiveBus>> getLiveBusesStream();

  // Report that a user is waiting at a terminal
  Future<void> reportWaitTime(String terminalId);
}
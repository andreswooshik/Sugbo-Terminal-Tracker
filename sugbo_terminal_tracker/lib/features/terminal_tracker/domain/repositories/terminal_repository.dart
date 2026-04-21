import '../entities/live_bus.dart';
import '../entities/terminal.dart';

sealed class Result<T, E extends Exception> {
  const Result();
}
class Success<T, E extends Exception> extends Result<T, E> {
  final T value;
  const Success(this.value);
}
class Failure<T, E extends Exception> extends Result<T, E> {
  final E error;
  const Failure(this.error);
}

// This is the contract our UI will use.
// It doesn't know or care about Supabase.
abstract class TerminalRepository {
  // Get a stream of live updates for all terminals
  Stream<Result<List<Terminal>, Exception>> getTerminalsStream();

  // Get a stream of live updates for all buses
  Stream<Result<List<LiveBus>, Exception>> getLiveBusesStream();

  // Report that a user is waiting at a terminal
  Future<Result<void, Exception>> reportWaitTime(String terminalId);
}

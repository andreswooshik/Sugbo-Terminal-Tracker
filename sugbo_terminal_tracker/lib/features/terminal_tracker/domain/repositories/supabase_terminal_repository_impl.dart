import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/entities/live_bus.dart';
import '../../domain/entities/terminal.dart';
import '../../domain/repositories/terminal_repository.dart';

class InvalidTerminalIdException implements Exception {
  final String message;
  InvalidTerminalIdException(this.message);
  @override
  String toString() => "InvalidTerminalIdException: $message";
}

class RateLimitException implements Exception {
  final String message;
  RateLimitException(this.message);
  @override
  String toString() => "RateLimitException: $message";
}

// This is the CONCRETE implementation. It knows how to talk to Supabase.
class SupabaseTerminalRepositoryImpl implements TerminalRepository {
  // Dependency injection via constructor
  final SupabaseClient _client;
  
  // Rate limiting structure
  final Map<String, DateTime> _lastReportedWaitTimes = {};
  
  // Caching Streams to avoid redundant subscriptions
  Stream<Result<List<Terminal>, Exception>>? _terminalsStreamCache;
  Stream<Result<List<LiveBus>, Exception>>? _busesStreamCache;

  SupabaseTerminalRepositoryImpl({required SupabaseClient client}) : _client = client;

  @override
  Stream<Result<List<Terminal>, Exception>> getTerminalsStream() {
    _terminalsStreamCache ??= _client
        .from('terminals')
        .stream(primaryKey: ['id'])
        .debounceTime(const Duration(milliseconds: 300)) // Debounce rapid updates
        .map<Result<List<Terminal>, Exception>>((list) {
      try {
        final terminals = list.map((json) {
          print('SUPABASE JSON: $json');
          return Terminal.fromJson(json);
        }).toList();
        return Success(terminals);
      } catch (e) {
        return Failure(Exception('Failed to parse terminals: $e'));
      }
    })
    .onErrorReturnWith((error, stackTrace) => Failure(Exception(error.toString())))
    .shareReplay(maxSize: 1); // Caching strategy

    return _terminalsStreamCache!;
  }

  @override
  Stream<Result<List<LiveBus>, Exception>> getLiveBusesStream() {
    _busesStreamCache ??= _client
        .from('buses')
        .stream(primaryKey: ['id'])
        .debounceTime(const Duration(milliseconds: 300)) // Debounce rapid updates
        .map<Result<List<LiveBus>, Exception>>((list) {
      try {
        final buses = list.map((json) => LiveBus.fromJson(json)).toList();
        return Success(buses);
      } catch (e) {
        return Failure(Exception('Failed to parse live buses: $e'));
      }
    })
    .onErrorReturnWith((error, stackTrace) => Failure(Exception(error.toString())))
    .shareReplay(maxSize: 1); // Caching strategy

    return _busesStreamCache!;
  }

  @override
  Future<Result<void, Exception>> reportWaitTime(String terminalId) async {
    // 1. Input validation
    if (terminalId.isEmpty || terminalId.length > 100) {
      return Failure(InvalidTerminalIdException('Terminal ID is missing or invalid.'));
    }
    
    // 2. Rate limiting check (e.g. max 1 report every 2 minutes per terminal per client session)
    final now = DateTime.now();
    final lastReported = _lastReportedWaitTimes[terminalId];
    if (lastReported != null && now.difference(lastReported).inMinutes < 2) {
      return Failure(RateLimitException('You can only report wait time once every 2 minutes.'));
    }

    try {
      // 3. Update using server-side timestamp "now()"
      // Alternatively, could use an Edge Function if configured on Supabase
      // e.g., await _client.functions.invoke('report-wait-time', body: {'terminalId': terminalId});
      await _client.from('terminals').update({
        'last_updated': 'now()',
      }).eq('id', terminalId);
      
      _lastReportedWaitTimes[terminalId] = now;
      return const Success(null);
    } catch (e) {
      return Failure(Exception('Failed to report wait time: $e'));
    }
  }
}

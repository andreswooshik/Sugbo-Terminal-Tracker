import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repositories/terminal_repository.dart';
import '../repositories/supabase_terminal_repository_impl.dart';
import '../usecases/report_wait_time.dart';
import '../entities/terminal.dart';
import '../models/terminal_model.dart';

// 1. Provide the Supabase Client (Dependency injection)
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// 2. Provide the Repository using the injected client
final terminalRepositoryProvider = Provider<TerminalRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseTerminalRepositoryImpl(client: client);
});

// 3. Provide Use Cases
final reportWaitTimeUseCaseProvider = Provider<ReportWaitTimeUseCase>((ref) {
  final repository = ref.watch(terminalRepositoryProvider);
  return ReportWaitTimeUseCase(repository);
});

// 4. MAPPER PROVIDER (Stream)
// Listens to the Repository's Entity stream, handles Success/Failure, and maps to the UI Model.
final terminalsStreamProvider = StreamProvider.autoDispose<List<TerminalUiModel>>((ref) {
  final repository = ref.watch(terminalRepositoryProvider);
  
  return repository.getTerminalsStream().map((result) {
    if (result is Success<List<Terminal>, Exception>) {
      // Data found and parsed successfully
      return result.value.map((entity) {
        
        // Dynamic styling logic based on the wait time
        String colorHex = '#1DB954'; // Default Green (Good)
        int waitTime = entity.waitTime ?? 0;
        if (waitTime > 15) {
          colorHex = '#E91E63'; // Red/Pink (Long wait)
        } else if (waitTime > 5) {
          colorHex = '#FFA500'; // Orange (Medium wait)
        }
        
        // Override color for BRT anchors (optional logic from your mockup)
        String operatorName = entity.operator ?? 'Unknown';
        if (operatorName.toLowerCase().contains('brt')) {
          colorHex = '#1A73E8'; // Blue
        }
        
        return TerminalUiModel(
          id: entity.id,
          name: entity.name,
          subtitle: operatorName,
          estimatedWaitTime: '~${waitTime} min wait',
          isFree: operatorName.toLowerCase().contains('brt'), 
          statusColorHex: colorHex,
        );
      }).toList();
    } else if (result is Failure<List<Terminal>, Exception>) {
      // If we failed inside the stream, we throw so Riverpod's AsyncError catches it
      throw result.error;
    }
    
    // Fallback empty list
    return [];
  });
});


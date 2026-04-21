import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../terminals/domain/providers/terminal_providers.dart' as terminals_feature;
import '../../../terminals/models/terminal_wait_model.dart';
import '../models/terminal_model.dart';

// Convert TerminalWaitModel to TerminalUiModel
TerminalUiModel _convertToUiModel(TerminalWaitModel model, int index) {
  return TerminalUiModel(
    id: 'terminal_$index',
    name: model.name,
    subtitle: model.description,
    estimatedWaitTime: model.waitTime,
    isFree: model.isFree,
    statusColorHex: '#${model.accentColor.value.toRadixString(16).substring(2)}',
  );
}

// Provide a stream of TerminalUiModel for the home screen
final terminalsStreamProvider = StreamProvider.autoDispose<List<TerminalUiModel>>((ref) async* {
  final terminalsAsync = ref.watch(terminals_feature.terminalsStreamProvider);
  
  await for (final result in terminalsAsync) {
    if (result.isNotEmpty) {
      // Convert each TerminalWaitModel to TerminalUiModel
      final uiModels = result.asMap().entries.map((entry) {
        return _convertToUiModel(entry.value, entry.key);
      }).toList();
      yield uiModels;
    } else {
      yield [];
    }
  }
});

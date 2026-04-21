import 'package:freezed_annotation/freezed_annotation.dart';

part 'terminal.freezed.dart';
part 'terminal.g.dart';

@freezed
abstract class Terminal with _$Terminal {
  const factory Terminal({
    required String id,
    required String name,
    required String operator, // e.g., "BRT anchor", "MyBus main hub"
    required int waitTime, // in minutes
    required DateTime lastUpdated,
    required int routesAvailable,
  }) = _Terminal;

  factory Terminal.fromJson(Map<String, dynamic> json) => _$TerminalFromJson(json);
}
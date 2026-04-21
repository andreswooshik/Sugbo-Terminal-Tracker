import 'package:freezed_annotation/freezed_annotation.dart';

part 'terminal.freezed.dart';
part 'terminal.g.dart';

@freezed
abstract class Terminal with _$Terminal {
  const factory Terminal({
    required String id,
    required String name,
    String? operator, // e.g., "BRT anchor", "MyBus main hub"
    @JsonKey(name: 'wait_time') int? waitTime, // in minutes
    @JsonKey(name: 'last_updated') DateTime? lastUpdated,
    @JsonKey(name: 'routes_available') int? routesAvailable,
  }) = _Terminal;

  factory Terminal.fromJson(Map<String, dynamic> json) => _$TerminalFromJson(json);
}

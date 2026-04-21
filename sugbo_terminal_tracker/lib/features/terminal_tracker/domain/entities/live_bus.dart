import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_bus.freezed.dart';
part 'live_bus.g.dart';

@freezed
abstract class LiveBus with _$LiveBus {
  const factory LiveBus({
    required String id,
    required String routeId,
    required String lastKnownStop,
    required String direction, // 'Southbound' or 'Northbound'
  }) = _LiveBus;

  factory LiveBus.fromJson(Map<String, dynamic> json) => _$LiveBusFromJson(json);
}
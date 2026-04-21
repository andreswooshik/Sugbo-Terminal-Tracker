import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_bus.freezed.dart';
part 'live_bus.g.dart';

@freezed
abstract class LiveBus with _$LiveBus {
  const factory LiveBus({
    required String id,
    @JsonKey(name: 'route_id') required String routeId,
    @JsonKey(name: 'last_known_stop') required String lastKnownStop,
    required String direction, // 'Southbound' or 'Northbound'
  }) = _LiveBus;

  factory LiveBus.fromJson(Map<String, dynamic> json) => _$LiveBusFromJson(json);
}

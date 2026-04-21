// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_bus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveBus _$LiveBusFromJson(Map<String, dynamic> json) => _LiveBus(
  id: json['id'] as String,
  routeId: json['route_id'] as String,
  lastKnownStop: json['last_known_stop'] as String,
  direction: json['direction'] as String,
);

Map<String, dynamic> _$LiveBusToJson(_LiveBus instance) => <String, dynamic>{
  'id': instance.id,
  'route_id': instance.routeId,
  'last_known_stop': instance.lastKnownStop,
  'direction': instance.direction,
};

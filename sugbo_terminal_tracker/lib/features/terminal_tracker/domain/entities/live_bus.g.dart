// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_bus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveBus _$LiveBusFromJson(Map<String, dynamic> json) => _LiveBus(
  id: json['id'] as String,
  routeId: json['routeId'] as String,
  lastKnownStop: json['lastKnownStop'] as String,
  direction: json['direction'] as String,
);

Map<String, dynamic> _$LiveBusToJson(_LiveBus instance) => <String, dynamic>{
  'id': instance.id,
  'routeId': instance.routeId,
  'lastKnownStop': instance.lastKnownStop,
  'direction': instance.direction,
};

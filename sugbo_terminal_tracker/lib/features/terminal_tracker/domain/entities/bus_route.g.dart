// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusRoute _$BusRouteFromJson(Map<String, dynamic> json) => _BusRoute(
  id: json['id'] as String,
  name: json['name'] as String,
  operator: $enumDecode(_$OperatorEnumMap, json['operator']),
  fare: json['fare'] as String,
  scheduleSummary: json['scheduleSummary'] as String,
  southboundStops: (json['southboundStops'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  northboundStops: (json['northboundStops'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$BusRouteToJson(_BusRoute instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'operator': _$OperatorEnumMap[instance.operator]!,
  'fare': instance.fare,
  'scheduleSummary': instance.scheduleSummary,
  'southboundStops': instance.southboundStops,
  'northboundStops': instance.northboundStops,
};

const _$OperatorEnumMap = {
  Operator.brt: 'brt',
  Operator.myBus: 'myBus',
  Operator.loveBus: 'loveBus',
};

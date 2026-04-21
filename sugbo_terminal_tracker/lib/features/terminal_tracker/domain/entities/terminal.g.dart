// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Terminal _$TerminalFromJson(Map<String, dynamic> json) => _Terminal(
  id: json['id'] as String,
  name: json['name'] as String,
  operator: json['operator'] as String?,
  waitTime: (json['wait_time'] as num?)?.toInt(),
  lastUpdated: json['last_updated'] == null
      ? null
      : DateTime.parse(json['last_updated'] as String),
  routesAvailable: (json['routes_available'] as num?)?.toInt(),
);

Map<String, dynamic> _$TerminalToJson(_Terminal instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'operator': instance.operator,
  'wait_time': instance.waitTime,
  'last_updated': instance.lastUpdated?.toIso8601String(),
  'routes_available': instance.routesAvailable,
};

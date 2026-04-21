// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Terminal _$TerminalFromJson(Map<String, dynamic> json) => _Terminal(
  id: json['id'] as String,
  name: json['name'] as String,
  operator: json['operator'] as String,
  waitTime: (json['waitTime'] as num).toInt(),
  lastUpdated: DateTime.parse(json['lastUpdated'] as String),
  routesAvailable: (json['routesAvailable'] as num).toInt(),
);

Map<String, dynamic> _$TerminalToJson(_Terminal instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'operator': instance.operator,
  'waitTime': instance.waitTime,
  'lastUpdated': instance.lastUpdated.toIso8601String(),
  'routesAvailable': instance.routesAvailable,
};

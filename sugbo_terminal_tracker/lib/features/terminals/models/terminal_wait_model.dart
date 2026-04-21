import 'package:flutter/material.dart';

class TerminalWaitModel {
  final String name;
  final String description;
  final String waitTime;
  final String routeCount;
  final String updatedTime;
  final bool isFree;
  final Color accentColor;

  TerminalWaitModel({
    required this.name,
    required this.description,
    required this.waitTime,
    required this.routeCount,
    required this.updatedTime,
    this.isFree = false,
    required this.accentColor,
  });

  factory TerminalWaitModel.fromMap(Map<String, dynamic> map) {
    return TerminalWaitModel(
      name: map['name'] as String,
      description: map['description'] as String,
      waitTime: map['wait_time'] as String,
      routeCount: map['route_count'] as String,
      updatedTime: map['last_updated'] as String,
      isFree: (map['is_free'] as int) == 1,
      accentColor: _hexToColor(map['accent_color'] as String),
    );
  }

  static Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'wait_time': waitTime,
      'route_count': routeCount,
      'last_updated': updatedTime,
      'is_free': isFree ? 1 : 0,
      'accent_color': '#${accentColor.value.toRadixString(16).substring(2)}',
    };
  }
}

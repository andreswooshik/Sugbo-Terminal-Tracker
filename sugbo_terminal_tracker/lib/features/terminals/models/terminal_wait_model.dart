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
      name: map['name'],
      description: map['description'],
      waitTime: map['waitTime'],
      routeCount: map['routeCount'],
      updatedTime: map['updatedTime'],
      isFree: map['isFree'] == 1,
      accentColor: Color(int.parse(map['accentColorHex'], radix: 16)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'waitTime': waitTime,
      'routeCount': routeCount,
      'updatedTime': updatedTime,
      'isFree': isFree ? 1 : 0,
      'accentColorHex': accentColor.value.toRadixString(16).padLeft(8, '0'),
    };
  }
}

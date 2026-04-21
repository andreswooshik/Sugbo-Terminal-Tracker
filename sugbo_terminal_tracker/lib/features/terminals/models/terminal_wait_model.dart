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
}

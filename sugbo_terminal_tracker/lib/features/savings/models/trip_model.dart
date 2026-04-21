import 'package:flutter/material.dart';

class TripModel {
  final String route;
  final String timestamp;
  final String provider;
  final String savings;
  final Color accentColor;
  final Color providerColor;

  TripModel({
    required this.route,
    required this.timestamp,
    required this.provider,
    required this.savings,
    required this.accentColor,
    required this.providerColor,
  });
}

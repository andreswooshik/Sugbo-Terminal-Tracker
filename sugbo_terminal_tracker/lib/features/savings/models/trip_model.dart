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

  factory TripModel.fromMap(Map<String, dynamic> map) {
    return TripModel(
      route: map['route'],
      timestamp: map['timestamp'],
      provider: map['provider'],
      savings: map['savings'],
      accentColor: Color(int.parse(map['accentColorHex'], radix: 16)),
      providerColor: Color(int.parse(map['providerColorHex'], radix: 16)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'route': route,
      'timestamp': timestamp,
      'provider': provider,
      'savings': savings,
      'accentColorHex': accentColor.value.toRadixString(16).padLeft(8, '0'),
      'providerColorHex': providerColor.value.toRadixString(16).padLeft(8, '0'),
    };
  }
}

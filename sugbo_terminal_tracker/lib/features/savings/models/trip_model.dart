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
      route: map['route'] as String,
      timestamp: map['timestamp'] as String,
      provider: map['provider'] as String,
      savings: '₱${(map['savings_amount'] as num).toStringAsFixed(0)}',
      accentColor: _hexToColor(map['accent_color'] as String),
      providerColor: _hexToColor(map['provider_color'] as String),
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
      'route': route,
      'timestamp': timestamp,
      'provider': provider,
      'savings_amount': double.tryParse(savings.replaceAll('₱', '')) ?? 0.0,
      'accent_color': '#${accentColor.value.toRadixString(16).substring(2)}',
      'provider_color': '#${providerColor.value.toRadixString(16).substring(2)}',
    };
  }
}

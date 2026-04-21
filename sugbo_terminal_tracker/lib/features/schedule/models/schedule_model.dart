import 'package:flutter/material.dart';

class ScheduleModel {
  final String providerBadge;
  final String routeName;
  final String routeDetails;
  final String priceLabel;
  final String frequencyLabel;
  final Color accentColor;
  final bool isFree;

  ScheduleModel({
    required this.providerBadge,
    required this.routeName,
    required this.routeDetails,
    required this.priceLabel,
    required this.frequencyLabel,
    required this.accentColor,
    this.isFree = false,
  });

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      providerBadge: map['provider_badge'] as String,
      routeName: map['route_name'] as String,
      routeDetails: map['route_details'] as String,
      priceLabel: map['price_label'] as String,
      frequencyLabel: map['frequency_label'] as String,
      accentColor: _hexToColor(map['accent_color'] as String),
      isFree: (map['is_free'] as int) == 1,
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
      'provider_badge': providerBadge,
      'route_name': routeName,
      'route_details': routeDetails,
      'price_label': priceLabel,
      'frequency_label': frequencyLabel,
      'accent_color': '#${accentColor.value.toRadixString(16).substring(2)}',
      'is_free': isFree ? 1 : 0,
    };
  }
}

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
      providerBadge: map['providerBadge'],
      routeName: map['routeName'],
      routeDetails: map['routeDetails'],
      priceLabel: map['priceLabel'],
      frequencyLabel: map['frequencyLabel'],
      accentColor: Color(int.parse(map['accentColorHex'], radix: 16)),
      isFree: map['isFree'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'providerBadge': providerBadge,
      'routeName': routeName,
      'routeDetails': routeDetails,
      'priceLabel': priceLabel,
      'frequencyLabel': frequencyLabel,
      'accentColorHex': accentColor.value.toRadixString(16).padLeft(8, '0'),
      'isFree': isFree ? 1 : 0,
    };
  }
}

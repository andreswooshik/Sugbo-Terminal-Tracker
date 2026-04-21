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
}

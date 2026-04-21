import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/transit_route_model.dart';
import 'route_card.dart';

class RouteList extends StatelessWidget {
  final List<TransitRoute> routes;

  const RouteList({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular routes now',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        // Render the cards dynamically
        ...routes.map((route) => RouteCard(route: route)).toList(),
      ],
    );
  }
}

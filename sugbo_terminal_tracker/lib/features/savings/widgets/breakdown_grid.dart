import 'package:flutter/material.dart';

class BreakdownGrid extends StatelessWidget {
  const BreakdownGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.8,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildStatCard(
          'FREE rides',
          '12',
          'Love Bus + Libreng',
          const Color(0xFF00FF9D),
        ),
        _buildStatCard(
          'Paid rides',
          '3',
          'MyBus routes',
          const Color(0xFFE040FB),
        ),
        _buildStatCard(
          'Total cost',
          '₱150',
          'Actual spent',
          const Color(0xFFFFB300),
        ),
        _buildStatCard(
          'Avg saved/trip',
          '₱82',
          'Per commute',
          const Color(0xFF00B0FF),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String mainValue,
    String subtitle,
    Color mainColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E222D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 4),
          Text(
            mainValue,
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white38, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

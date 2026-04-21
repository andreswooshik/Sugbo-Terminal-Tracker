import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bottomNavBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 24, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildNavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            isActive: true,
          ),
          _buildNavItem(
            icon: Icons.swap_horiz,
            label: 'Routes',
            isActive: false,
          ),
          _buildNavItem(
            icon: Icons.radio_button_checked,
            label: 'Terminals',
            isActive: false,
          ),
          _buildNavItem(
            icon: Icons.access_time,
            label: 'Schedule',
            isActive: false,
          ),
          _buildNavItem(
            icon: Icons.payments_outlined,
            label: 'Savings',
            isActive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    final color = isActive
        ? Colors.lightBlueAccent
        : AppColors.textSecondary.withOpacity(0.6);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        // Active dot indicator
        if (isActive)
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.lightBlueAccent,
              shape: BoxShape.circle,
            ),
          )
        else
          const SizedBox(height: 4),
      ],
    );
  }
}

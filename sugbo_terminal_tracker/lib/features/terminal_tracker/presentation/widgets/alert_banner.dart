import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AlertBanner extends StatelessWidget {
  const AlertBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bannerBackground.withOpacity(
          0.9,
        ), // Slightly transparent green
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          // Green dot indicator and "FREE" tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.accentGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'FREE',
                  style: TextStyle(
                    color: AppColors.accentGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Main text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BRT Love Bus active until 9:00 AM',
                  style: TextStyle(
                    color: AppColors.cardBackground,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'IT Park ↔ Il Corso · No fare required',
                  style: TextStyle(
                    color: AppColors.cardBackground.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Right arrow icon
          Icon(
            Icons.chevron_right,
            color: AppColors.cardBackground.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}

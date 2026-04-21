import 'package:flutter/material.dart';

class DiskarteScoreCard extends StatelessWidget {
  const DiskarteScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withValues(
          alpha: 0.2,
        ), // Semi-transparent blue overlay
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.lightBlueAccent.withValues(alpha: 0.3)),
        // Adding a slight blur backdrop effect if you want, but simple color works
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Diskarte score',
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "You leveraged existing BRT & MyBus routes without asking for new infrastructure. That's the diskarte.",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

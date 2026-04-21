import 'package:flutter/material.dart';

class TotalSavedCard extends StatelessWidget {
  final double totalAmount;

  const TotalSavedCard({Key? key, this.totalAmount = 1240.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF4B8C9F).withOpacity(0.5), // A muted teal/blue bg
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF32A68E), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Large Peso icon
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: const Center(
                  child: Text(
                    '₱',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00FF9D),
                      height: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total saved this week',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '₱ ',
                        style: TextStyle(
                          color: Color(0xFF00FF9D),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        totalAmount.toStringAsFixed(0),
                        style: const TextStyle(
                          color: Color(0xFF00FF9D),
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            '15 trips · 12 FREE rides · vs ₱2,850 Grab total',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NextDepartureTile extends StatelessWidget {
  final String destination;
  final String provider;
  final String estimate;
  final Color accentColor;

  const NextDepartureTile({
    super.key,
    required this.destination,
    required this.provider,
    required this.estimate,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E222D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.circle, color: accentColor, size: 8),
              const SizedBox(width: 12),
              Text(
                destination,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                provider,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 60, // Fixed width to align estimates
                child: Text(
                  estimate,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFFFFC107), // Amber
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

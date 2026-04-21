import 'package:flutter/material.dart';

class FreeRideBanner extends StatelessWidget {
  const FreeRideBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(
          0xFF4C5874,
        ), // A slightly lighter blue/grey card background
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, color: Colors.greenAccent, size: 8),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 12,
                  height: 1.4,
                ),
                children: [
                  const TextSpan(text: 'Love Bus FREE now on BRT - IT Park '),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(
                        Icons.compare_arrows,
                        color: Colors.greenAccent,
                        size: 14,
                      ),
                    ),
                  ),
                  const TextSpan(text: ' Il Corso (until 9:00 AM)'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

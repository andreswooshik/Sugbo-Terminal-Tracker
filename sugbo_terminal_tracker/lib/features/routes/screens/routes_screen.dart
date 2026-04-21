import 'package:flutter/material.dart';
import '../models/route_model.dart';
import '../widgets/location_input_card.dart';
import '../widgets/route_card.dart';
import '../widgets/savings_card.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data based on the screenshot
    final List<RouteModel> mockRoutes = [
      RouteModel(
        title: 'FREE NOW',
        subtitle: 'BRT Love Bus - until 9:00 AM',
        path: 'IT Park → Ayala → Fuente → Seaside → Il Corso',
        duration: '9 stops · ~35-40 min',
        price: '₱0.00',
        comparison: 'vs ₱150-200 Grab',
        status: 'Next bus: ~4 min',
        isFree: true,
      ),
      RouteModel(
        title: 'PAID',
        subtitle: 'BRT - 9:01 AM - 4:59 PM window',
        path: 'IT Park → Ayala → Fuente → Seaside → Il Corso',
        duration: 'Same route - same 9 stops · ~35-40 min',
        price: 'Regular fare',
        comparison: '',
        status: 'Every ~5-10 min during day',
        isFree: false,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(
        0xFF6B7B9E,
      ), // Background color showing behind Cards
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Check if we can pop to avoid black screen, or just let bottom nav handle it
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Route Finder',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'Find the cheapest route between terminals',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const LocationInputCard(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '2 routes found',
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                  'Save up to ₱150 vs Grab',
                  style: TextStyle(
                    color: Colors.greenAccent[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...mockRoutes.map((route) => RouteCard(route: route)).toList(),
            const SizedBox(height: 8),
            const SavingsCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

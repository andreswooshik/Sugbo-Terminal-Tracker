import 'package:flutter/material.dart';
import '../models/trip_model.dart';
import '../widgets/total_saved_card.dart';
import '../widgets/breakdown_grid.dart';
import '../widgets/recent_trip_card.dart';
import '../widgets/diskarte_score_card.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TripModel> mockTrips = [
      TripModel(
        route: 'IT Park → Il Corso',
        timestamp: 'Today 8:30 AM',
        provider: 'BRT',
        savings: '₱150',
        accentColor: const Color(0xFF00FF9D),
        providerColor: const Color(0xFF00FF9D),
      ),
      TripModel(
        route: 'SM Seaside → SM JMall',
        timestamp: 'Today 9:15 AM',
        provider: 'MyBus',
        savings: '₱80',
        accentColor: const Color(0xFFE040FB),
        providerColor: const Color(0xFFE040FB),
      ),
      TripModel(
        route: 'Il Corso → IT Park',
        timestamp: 'Yesterday 6:00 PM',
        provider: 'BRT',
        savings: '₱150',
        accentColor: const Color(0xFF00FF9D),
        providerColor: const Color(0xFF00FF9D),
      ),
      TripModel(
        route: 'Anjo World → SM City',
        timestamp: 'Yesterday 7:30 AM',
        provider: 'MyBus',
        savings: '₱120',
        accentColor: const Color(0xFFE040FB),
        providerColor: const Color(0xFFE040FB),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF6B7B9E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Savings',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              "How much you've saved vs Grab/taxi",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const TotalSavedCard(),

              const Padding(
                padding: EdgeInsets.only(top: 24, bottom: 12),
                child: Text(
                  'This week breakdown',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
              const BreakdownGrid(),

              const Padding(
                padding: EdgeInsets.only(top: 24, bottom: 12),
                child: Text(
                  'Recent trips',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),

              ...mockTrips.map((trip) => RecentTripCard(trip: trip)).toList(),

              const SizedBox(height: 16),
              const DiskarteScoreCard(),
            ],
          ),
        ),
      ),
    );
  }
}

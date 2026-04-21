import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/savings_providers.dart';
import '../models/trip_model.dart';
import '../widgets/total_saved_card.dart';
import '../widgets/breakdown_grid.dart';
import '../widgets/recent_trip_card.dart';
import '../widgets/diskarte_score_card.dart';

class SavingsScreen extends ConsumerWidget {
  const SavingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the stream of trips from SQLite
    final tripsAsyncValue = ref.watch(tripsStreamProvider);
    // Watch total savings
    final totalSavingsAsync = ref.watch(totalSavingsProvider);

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
        child: tripsAsyncValue.when(
          data: (mockTrips) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Pass total savings to TotalSavedCard
                  totalSavingsAsync.when(
                    data: (savings) => TotalSavedCard(totalAmount: savings['total'] ?? 0.0),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, s) => const TotalSavedCard(totalAmount: 0.0),
                  ),

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

                  if (mockTrips.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                          'No trips recorded yet.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    )
                  else
                    ...mockTrips.map((trip) => RecentTripCard(trip: trip)).toList(),

                  const SizedBox(height: 16),
                  const DiskarteScoreCard(),
                ],
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          error: (error, stack) => Center(
            child: Text(
              'Error loading trips: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

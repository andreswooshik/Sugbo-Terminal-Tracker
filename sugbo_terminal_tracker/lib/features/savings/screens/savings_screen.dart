import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../models/trip_model.dart';
import '../providers/savings_providers.dart';
import '../widgets/total_saved_card.dart';
import '../widgets/diskarte_score_card.dart';
import '../widgets/breakdown_grid.dart';
import '../widgets/recent_trip_card.dart';

class SavingsScreen extends ConsumerWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripsAsync = ref.watch(tripsListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Savings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: tripsAsync.when(
          data: (mockTrips) => ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              const TotalSavedCard(),
              const SizedBox(height: 24),
              const DiskarteScoreCard(),
              const SizedBox(height: 24),
              const BreakdownGrid(),
              const SizedBox(height: 32),
              const Text(
                'Recent Diskarte Trips',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...mockTrips.map((trip) => RecentTripCard(trip: trip)).toList(),
              const SizedBox(height: 32),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}

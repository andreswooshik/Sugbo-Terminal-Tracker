import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/terminal_model.dart';
import '../../domain/models/transit_route_model.dart';
import '../widgets/greeting_card.dart';
import '../widgets/alert_banner.dart';
import '../widgets/status_card.dart';
import '../widgets/terminal_grid.dart';
import '../widgets/route_list.dart';
import '../widgets/custom_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data matching the Figma design for the Terminal Grid
    final List<Terminal> dummyTerminals = [
      Terminal(
        id: '1',
        name: 'IT Park',
        subtitle: 'BRT anchor',
        estimatedWaitTime: '~3 min wait',
        isFree: true,
        statusColorHex: '#1A73E8',
      ), // Blue dot
      Terminal(
        id: '2',
        name: 'SM Seaside',
        subtitle: 'BRT + MyBus',
        estimatedWaitTime: '~3 min wait',
        isFree: true,
        statusColorHex: '#1DB954',
      ), // Green dot
      Terminal(
        id: '3',
        name: 'SM City',
        subtitle: 'MyBus main hub',
        estimatedWaitTime: '~3 min wait',
        isFree: false,
        statusColorHex: '#1DB954',
      ),
      Terminal(
        id: '4',
        name: 'Il Corso',
        subtitle: 'BRT terminus',
        estimatedWaitTime: '~3 min wait',
        isFree: true,
        statusColorHex: '#1A73E8',
      ),
      Terminal(
        id: '5',
        name: 'SM JMall',
        subtitle: 'MyBus Mandaue',
        estimatedWaitTime: '~3 min wait',
        isFree: false,
        statusColorHex: '#1DB954',
      ),
      Terminal(
        id: '6',
        name: 'Anjo World',
        subtitle: 'Love Bus + MyBus',
        estimatedWaitTime: '~3 min wait',
        isFree: true,
        statusColorHex: '#E91E63',
      ), // Pink dot
    ];

    // Dummy data matching the Figma design for the Routes List
    final List<TransitRoute> dummyRoutes = [
      TransitRoute(
        id: '1',
        providerName: 'BRT',
        origin: 'IT Park',
        destination: 'Il Corso',
        frequency: 'Every 20 min',
        price: 'FREE',
      ),
      TransitRoute(
        id: '2',
        providerName: 'MyBus',
        origin: 'Anjo World',
        destination: 'SM City',
        frequency: 'Every 20 min',
        price: '₱50',
      ),
      TransitRoute(
        id: '3',
        providerName: 'MyBus',
        origin: 'SM Seaside',
        destination: 'SM JMall',
        frequency: 'Every 20 min',
        price: '₱30',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header text
              const Text(
                'Sugbo Tracker',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Cebu transit · real-time',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
              const SizedBox(height: 20),

              // The components we built
              const GreetingCard(),
              const SizedBox(height: 16),

              const AlertBanner(),
              const SizedBox(height: 16),

              const StatusCard(),
              const SizedBox(height: 24),

              // The Terminal Grid with our dummy data
              TerminalGrid(terminals: dummyTerminals),

              const SizedBox(height: 24),
              // Popular Routes
              RouteList(routes: dummyRoutes),
              const SizedBox(
                height: 24,
              ), // Extra padding at the bottom to breathe above the nav bar
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}

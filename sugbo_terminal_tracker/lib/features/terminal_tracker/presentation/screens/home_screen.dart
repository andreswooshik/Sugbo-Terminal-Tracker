import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/transit_route_model.dart';
import '../../domain/providers/terminal_providers.dart'; // Import our new provider
import '../widgets/greeting_card.dart';
import '../widgets/alert_banner.dart';
import '../widgets/status_card.dart';
import '../widgets/terminal_grid.dart';
import '../widgets/route_list.dart';
import '../widgets/custom_bottom_nav.dart';

class HomeScreen extends ConsumerWidget {
  final bool showBottomNav;

  const HomeScreen({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the live stream of Terminal Ui Models from Supabase
    final terminalsAsyncValue = ref.watch(terminalsStreamProvider);

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
        price: '?50',
      ),
      TransitRoute(
        id: '3',
        providerName: 'MyBus',
        origin: 'SM Seaside',
        destination: 'SM JMall',
        frequency: 'Every 20 min',
        price: '?30',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Sugbo Tracker',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              'Cebu transit · real-time',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.textPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // The components we built
                const GreetingCard(),
                const SizedBox(height: 16),

                const AlertBanner(),
                const SizedBox(height: 16),

                const StatusCard(),
                const SizedBox(height: 24),

                // Map the AsyncValue to the proper UI (Data, Loading, Error)
                terminalsAsyncValue.when(
                  data: (terminals) {
                    if (terminals.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "No terminals found.",
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      );
                    }
                    return TerminalGrid(terminals: terminals);
                  },
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ),
                  error: (error, stack) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Error loading terminals: $error",
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                // Popular Routes
                RouteList(routes: dummyRoutes),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: showBottomNav
          ? CustomBottomNav(onTap: (_) {}, selectedIndex: 0)
          : null,
    );
  }
}

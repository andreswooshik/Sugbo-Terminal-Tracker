import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/transit_route_model.dart';
import '../../domain/providers/terminal_providers.dart'; 
import '../../../../features/routes/providers/route_providers.dart';
import '../../../../features/routes/models/route_model.dart';
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
    // Watch the live stream of Terminal Ui Models from SQLite
    final terminalsAsyncValue = ref.watch(terminalsStreamProvider);
    final routesAsyncValue = ref.watch(routesListProvider);

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
                // Popular Routes Section
                routesAsyncValue.when(
                  data: (routes) {
                    final transitRoutes = routes
                        .take(3)
                        .map((r) => TransitRoute(
                              id: r.id?.toString() ?? '',
                              providerName: r.title.contains('BRT') ||
                                      r.title.contains('FREE')
                                  ? 'BRT'
                                  : 'MyBus',
                              origin: r.origin,
                              destination: r.destination,
                              frequency: r.status,
                              price: r.isFree ? 'FREE' : r.price,
                            ))
                        .toList();

                    return RouteList(routes: transitRoutes);
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accentGreen,
                    ),
                  ),
                  error: (error, stack) => Text(
                    'Error loading routes: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
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

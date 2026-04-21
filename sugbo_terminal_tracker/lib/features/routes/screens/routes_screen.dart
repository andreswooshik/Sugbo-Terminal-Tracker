import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../models/route_model.dart';
import '../providers/route_providers.dart';
import '../widgets/location_input_card.dart';
import '../widgets/route_card.dart';
import '../widgets/savings_card.dart';

class RoutesScreen extends ConsumerStatefulWidget {
  const RoutesScreen({super.key});

  @override
  ConsumerState<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends ConsumerState<RoutesScreen> {
  List<RouteModel> _searchedRoutes = [];
  bool _hasSearched = false;
  bool _isLoading = false;

  void _onSearch(Map<String, String>? from, Map<String, String>? to) async {
    if (from == null || to == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both Origin and Destination'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String fromTitle = from['title']!;
    final String toTitle = to['title']!;

    // Query via the injected RouteRepository (DIP)
    final repository = ref.read(routeRepositoryProvider);
    final routes = await repository.getRoutes(fromTitle, toTitle);

    setState(() {
      _hasSearched = true;
      _isLoading = false;
      _searchedRoutes = routes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            LocationInputCard(onSearch: _onSearch),
            if (_isLoading) ...[
              const SizedBox(height: 48),
              const Center(child: CircularProgressIndicator()),
            ] else if (_hasSearched) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_searchedRoutes.length} routes found',
                    style: const TextStyle(color: Colors.white70),
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
              ..._searchedRoutes
                  .map((route) => RouteCard(route: route))
                  .toList(),
              const SizedBox(height: 8),
              const SavingsCard(),
              const SizedBox(height: 24),
            ] else ...[
              const SizedBox(height: 48),
              const Center(
                child: Text(
                  'Select origin and destination\nto view available routes',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
